class Note < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :body, presence: true
end
