require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

module QuestionFollow
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        questions_follows ON questions_follows.user_id = users.id
      WHERE
        questions_follows.question_id = ? ;
    SQL

    results.map{|user_row| User.new(user_row)}
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        questions_follows ON questions_follows.question_id = questions.id
      WHERE
        questions_follows.user_id = ? ;
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        questions_follows ON questions_follows.question_id = questions.id
      JOIN
        users ON questions_follows.user_id = users.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(users.id) DESC LIMIT(?);
    SQL

    results.map{|question_row| Question.new(question_row)}
  end

  
end
