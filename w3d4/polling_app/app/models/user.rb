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
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        responses.respondent_id = :id OR responses.respondent_id IS NULL
      GROUP BY
        polls.id
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id);
    SQL
  end

  def completed_polls_ar
     Poll.select('polls.*')
    .joins(:answer_choices)
    .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
    .where('responses.respondent_id = ? OR respondent_id IS NULL', id)
    .group('polls.id')
    .having('COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id)')
  end
end
