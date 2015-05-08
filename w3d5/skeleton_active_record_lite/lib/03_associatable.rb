require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  attr_reader :foreign_key, :primary_key, :class_name

  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || get_foreign_key(name)
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || get_class_name(name)
  end

  def get_foreign_key(name)
    (name.to_s + '_id').to_sym
  end

  def get_class_name(name)
    name.to_s.singularize.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || get_foreign_key(self_class_name)
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || get_class_name(name)
  end

  def get_foreign_key(self_class_name)
    (self_class_name.underscore + '_id').to_sym
  end

  def get_class_name(name)
    name.to_s.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      results = DBConnection.instance.execute(<<-SQL, self.send(options.foreign_key))
        SELECT
          *
        FROM
          #{options.table_name}
        WHERE
          #{options.table_name}.#{options.primary_key} = ?
      SQL

      if results == []
        nil
      else
        options.model_class.new(results[0])
      end
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name,  options)
    define_method(name) do
      results = DBConnection.instance.execute(<<-SQL, self.send(options.primary_key))
        SELECT
          *
        FROM
          #{options.table_name}
        WHERE
          #{options.table_name}.#{options.foreign_key} = ?
      SQL
      relations = []
      results.each do |result|
        relations << options.model_class.new(result)
      end
      relations
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
