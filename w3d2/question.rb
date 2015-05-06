require_relative 'questions_database.rb'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'
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

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def author
    User.find_by_id(author_id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.execute(<<-SQL, title: title, body: body, author_id: author_id)
        INSERT INTO
          questions(title, body, author_id)
        VALUES
          (:title, :body, :author_id);
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.execute(<<-SQL, title: title, body: body, author_id: author_id, id: id)
        UPDATE
          questions
        SET
          title = :title, body = :body, author_id = :author_id
        WHERE
          id = :id;
      SQL
    end
    self
  end





  # def save
  #   table_name = self.class.name.downcase.pluralize
  #
  #   cols_array = self.instance_variables.inject([]) do |memo, col_name|
  #     memo << col_name.to_s[1..-1]
  #   end
  #
  #   cols_array -= ["id"]
  #
  #   args = cols_array.map { |col_val| self.send(col_val.to_sym) }
  #   cols_string = cols_array.join(', ')
  #   q_marks_string = ('?, ' * args.count)[0..-3]
  #
  #   if id.nil?
  #     QuestionsDatabase.execute(<<-SQL, cols_string, *args)
  #       INSERT INTO
  #         (#{table_name}(#{cols_string}))
  #       VALUES
  #         (#{q_marks_string});
  #     SQL
  #     @id = QuestionsDatabase.instance.last_insert_row_id
  #   else
  #     QuestionsDatabase.execute(<<-SQL, title: title, body: body, author_id: author_id, id: id)
  #       UPDATE
  #         questions
  #       SET
  #         title = :title, body = :body, author_id = :author_id
  #       WHERE
  #         id = :id;
  #     SQL
  #   end
  #   self
  # end
  #

  

end
