class Comment < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )
  belongs_to :post
  has_many(
    :sub_comments,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  belongs_to(
    :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  validates :author, :post, :content, presence: true
  default_scope {order(id: :desc)}
end
