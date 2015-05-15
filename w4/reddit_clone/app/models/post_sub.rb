class PostSub < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub

  validates :post, :sub, presence: true
  validates :post, uniqueness: { scope: :sub }
end
