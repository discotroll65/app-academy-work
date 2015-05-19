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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  
  it "persists to the database" do
    Goal.create!(body: "I want to do all the situps",
      title: "Situps",
      user_id: 1
      )

    expect(Goal.first.title).to eq("Situps")
    expect(Goal.first.public).to be( false )
    expect(Goal.first.completed).to be( false )

  end
end
