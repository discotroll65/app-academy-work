require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'question_follow'
require_relative 'question_like'
require 'pry'

class User
  attr_reader :id
  attr_accessor :fname, :lname

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

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?;
    SQL

    User.new(result[0])
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_author_id(id)
  end

  def average_karma
    results = nil
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.execute(<<-SQL, fname: fname, lname: lname)
        INSERT INTO
          users(fname, lname)
        VALUES
          (:fname, :lname);
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.execute(<<-SQL, fname: fname, lname: lname, id: id)
        UPDATE
          users
        SET
          fname = :fname , lname = :lname
        WHERE
          id = :id;
      SQL
    end

    self
  end
end
