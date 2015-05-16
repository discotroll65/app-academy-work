class Post < ActiveRecord::Base
  belongs_to :sub
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )
  has_many :post_subs
  has_many :subs, through: :post_subs
  has_many :comments, dependent: :destroy

  validates :title, :author_id, presence: true
end
