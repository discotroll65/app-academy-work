class Poll < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    through: :questions,
    source: :answer_choices
  )
end
