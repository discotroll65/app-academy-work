class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results

    raw_data = answer_choices
      .select('answer_choices.text, COUNT(respondent_id) AS num_votes')
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .group("answer_choices.id")



    question_results = raw_data.map do |answer_choice|
      [answer_choice.text, answer_choice.num_votes]
    end

    question_results.to_h
  end

end
