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
    question.responses.where(":id IS NULL OR responses.id != :id ", id: id)
  end

  private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(respondent_id: respondent_id)
      errors[:respondent_id] << "can't answer a question twice."
    end
  end

  def respondent_cannot_answer_own_poll
    if answer_choice.question.poll.author.id == respondent_id
      errors[:respondent_id] << "can't answer your own poll."
    end
  end
end
