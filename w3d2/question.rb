require_relative 'questions_database.rb'
require 'pry'

class Question
  def initialize(attrs = {})
    @id, @title, @body, @author_id = attrs['id'], attrs['title'],
      attrs['body'], attrs['author_id']
  end

  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL
    Question.new(result[0])
  end


end
