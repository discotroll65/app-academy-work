require_relative 'questions_database.rb'
require_relative 'user'
require_relative 'reply'
require 'pry'

class Question
  attr_reader :id, :author_id
  attr_accessor :title, :body


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

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?;
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  

end
