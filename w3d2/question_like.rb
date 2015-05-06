require_relative 'user'
require_relative 'question'
require_relative 'questions_database'
require 'pry'


module QuestionLike

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        questions_likes ON questions_likes.user_id = users.id
      WHERE
        questions_likes.question_id = ?
    SQL

    results.map{|user_row| User.new(user_row)}
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        questions_likes ON questions_likes.question_id = questions.id
      WHERE
        questions_likes.user_id = ? ;
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  def self.num_likes_for_question_id(question_id)
    like_count = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        COUNT(questions_likes.id) AS like_count
      FROM
        users
      JOIN
        questions_likes ON questions_likes.user_id = users.id
      WHERE
        questions_likes.question_id = ?
    SQL

    like_count[0]['like_count']
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        questions_likes ON questions_likes.question_id = questions.id
      JOIN
        users ON questions_likes.user_id = users.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(users.id) DESC LIMIT(?);
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  def self.average_karma_for_user_id(user_id)
    result = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        COUNT(questions_likes.question_id) /
        CAST(
          COUNT(DISTINCT(questions.id)) AS FLOAT
        ) AS avg_karma
      FROM
        questions
      LEFT OUTER JOIN
        questions_likes ON questions_likes.question_id = questions.id
      WHERE
        questions.author_id = ?
    SQL

    result[0]['avg_karma']
  end
end
