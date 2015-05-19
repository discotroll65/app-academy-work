FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    password {Faker::Internet.password}

    # factory :coolest_user do
    #   username "Ned"
    # end
  end
end
