require_relative 'questions_database.rb'

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

    result.map{|question_row| Question.new(question_row)}
  end


end
