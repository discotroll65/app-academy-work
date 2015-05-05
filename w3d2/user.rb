require_relative 'questions_database.rb'

class User
  def initialize(attrs = {})
    @id, @fname, @lname = attrs['id'], attrs['fname'], attrs['lname']

  end

  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL

    result.map{|user_row| User.new(user_row)}
  end

  
end
