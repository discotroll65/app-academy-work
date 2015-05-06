require_relative 'questions_database.rb'
require_relative 'user'
require_relative 'question'


class Reply
  attr_reader :id, :author_id, :parent_id, :question_id
  attr_accessor :body

  def initialize(attrs = {})
    @id, @question_id, @parent_id, @author_id, @body = attrs['id'],
      attrs['question_id'], attrs['parent_id'], attrs['author_id'],
      attrs['body']
  end

  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL

    results.map{|reply_row| Reply.new(reply_row)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL

    Reply.new(result[0])
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?;
    SQL

    results.map{|reply_row| Reply.new(reply_row)}
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?;
    SQL

    results.map{|reply_row| Reply.new(reply_row)}
  end

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    return nil unless parent_id
    Reply.find_by_id(parent_id)
  end

  def child_replies
    results = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?;
    SQL

    results.map{|reply_row| Reply.new(reply_row)}
  end

  def save
    if id.nil?
      QuestionsDatabase.execute(<<-SQL, question_id: question_id, parent_id: parent_id, author_id: author_id, body: body)
        INSERT INTO
          replies(question_id, parent_id, author_id, body)
        VALUES
          (:question_id, :parent_id, :author_id, :body);
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.execute(<<-SQL, question_id: question_id, parent_id: parent_id, author_id: author_id, body: body, id: id)
        UPDATE
          replies
        SET
          question_id = :question_id, parent_id = :parent_id, author_id = :author_id, body = :body
        WHERE
          id = :id;
      SQL
    end
    self
  end
end
