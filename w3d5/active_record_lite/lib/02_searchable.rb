require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    col_names = params.keys.map(&:to_s).join(' = ? AND ') + ' = ?'
    values = params.values
    results = DBConnection.instance.execute(<<-SQL, *values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{col_names}
    SQL

    results.map do |result|
      self.new(result)
    end

  end
end

class SQLObject
  extend Searchable
end
