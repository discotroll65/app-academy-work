class Response < ActiveRecord::Base
  validates :respondent_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question

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
    if id.nil?
      question.responses
    else
      question.responses.where("responses.id != ?", id)
    end
  end

  private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(respondent_id: respondent_id)
      errors[:respondent_id] << "can't answer a question twice."
    end
  end
end
