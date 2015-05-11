require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_belong_option = assoc_options[through_name]

    end_table = source_name.to_s.camelcase.constantize.table_name
    define_method(name) do
      end_belong_option = self.send(through_name).class.assoc_options[source_name]
      results = DBConnection.instance.execute(<<-SQL, self.send(through_name).send(through_belong_option.primary_key) )
        SELECT
          #{end_belong_option.table_name}.*
        FROM
          #{through_belong_option.table_name}
        JOIN
          #{end_belong_option.table_name}
        ON
          #{through_belong_option.table_name}.#{end_belong_option.foreign_key} = #{end_belong_option.table_name}.#{end_belong_option.primary_key}
        WHERE
        #{through_belong_option.table_name}.#{through_belong_option.primary_key} = ?
      SQL
      end_belong_option.model_class.new(results.first)
    end
  end
end
