class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many :posts

  validates :title, :description, presence: true
  validates :title, uniqueness: true
end
