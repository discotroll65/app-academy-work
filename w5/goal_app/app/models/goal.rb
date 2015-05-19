# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  public     :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :body, :user_id, :title, presence: true
  validates :public, :completed, inclusion: [true, false]

  belongs_to :user

  def public=(public)
    public == 'true'
    super(public)
  end
end
