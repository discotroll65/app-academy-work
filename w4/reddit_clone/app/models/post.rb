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

  def comment_tree_hash
    all_comments = Comment.where(post_id: id).includes(:author)
    all_comments.inject(Hash.new{|h,k| h[k] = [ ] }) do |hash, comment|
      hash.tap{ |h| h[comment.parent_comment_id] << comment }     
    end
  end
end
