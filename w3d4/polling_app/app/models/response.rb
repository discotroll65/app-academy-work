class Response < ActiveRecord::Base
  validates :respondent_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_answer_own_poll

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    sib_responses = Response
    .find_by_sql([<<-SQL, questions_answer: answer_choice_id, id: id ])
      SELECT
        sibs_response.*
      FROM
        responses
      JOIN
        answer_choices ON answer_choices.id = responses.answer_choice_id
      JOIN
        questions ON answer_choices.question_id = questions.id AND answer_choices.id = :questions_answer
      JOIN
        answer_choices AS sibs_answers ON questions.id = sibs_answers.question_id
      JOIN
        responses AS sibs_response ON sibs_answers.id = sibs_response.answer_choice_id
      WHERE
        :id IS NULL OR sibs_response.id != :id
    SQL

    sib_responses
  end

  private

  def respondent_has_not_already_answered_question
    sib_responses = sibling_responses
    if sib_responses.any?{|response| response.respondent_id == respondent_id}
      errors[:respondent_id] << "can't answer a question twice."
    end
  end

  def respondent_cannot_answer_own_poll
    poll = Poll.select('polls.*')
      .joins(:answer_choices)
      .where('answer_choices.id = ?', answer_choice_id)
      .first
    if poll.author_id == respondent_id
      errors[:respondent_id] << "can't answer your own poll."
    end
  end
end
