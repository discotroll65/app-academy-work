class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :author_id
  )

  has_many(
    :responses,
    class_name: 'Response',
    primary_key: :id,
    foreign_key: :respondent_id
  )

  def completed_polls
    Poll.find_by_sql([<<-SQL, id: id])
      SELECT
        polls.title, responses.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        responses.respondent_id = 3 AND responses.id IS NOT NULL

    SQL
  end
end
