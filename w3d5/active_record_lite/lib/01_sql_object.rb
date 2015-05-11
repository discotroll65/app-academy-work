require_relative 'db_connection'
require 'active_support/inflector'
require 'pry'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    results = DBConnection.instance.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL

    col_name_strings = results[0].dup

    col_name_syms = results[0].map{|col_name| col_name.to_sym}
  end

  def self.finalize!
    col_name_strings = columns

    col_name_strings.each do |col_name|
      define_method(col_name) do
        attributes[col_name]
      end

      define_method("#{col_name}=") do |val|
        attributes[col_name] = val
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL

    self.parse_all(results)

  end

  def self.parse_all(results)
    objects = []
    results.each do |result|
      result.delete("id")
      objects << self.new(result)
    end
    objects
  end

  def self.find(id)
  results = DBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        "#{self.table_name}"
      WHERE
        "#{self.table_name}".id = ?
    SQL
    return nil if results == []
    params = results[0]
    self.new(params)

  end

  def initialize(params = {})
    symd_params = params.map{|key, val| [key.to_sym, val]}.to_h
    class_columns = self.class.columns

    symd_params.each do |key, val|
      if class_columns.none?{|col_name| col_name == key }
        raise "unknown attribute '#{key}'"
      end

      self.send("#{key}=", val)
    end


  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values

  end

  def insert
    col_names = attributes.keys.map(&:to_s).join(', ')
    question_marks = (['?'] * attribute_values.length).join(', ')
    DBConnection.instance.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{ question_marks })
    SQL
    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update
    col_names = attributes.keys.map(&:to_s).join(' = ?, ') + ' = ?'
    question_marks = (['?'] * attribute_values.length).join(', ')
    DBConnection.execute(<<-SQL, *attribute_values)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = #{attributes[:id]}
    SQL
  end

  def save
    id.nil? ? self.insert : self.update
  end
end
