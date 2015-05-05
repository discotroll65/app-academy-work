require_relative 'questions_database.rb'
require 'pry'

class User
  def initialize(attrs = {})
    @id, @fname, @lname = attrs['id'], attrs['fname'], attrs['lname']

  end

  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        users;
    SQL

    results.map{|user_row| User.new(user_row)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL
    User.new(result[0])
  end
end
