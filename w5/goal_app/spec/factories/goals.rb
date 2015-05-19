FactoryGirl.define do
  factory :goal do
    title {Faker::Lorem.words(5)}
    body {Faker::Lorem.paragraph}


    factory :public_goal do
      public true
    end

    factory :completed_goal do
      completed true
    end

    factory :public_completed_goal do
      public true
      completed true
    end

    factory :owned_goal do
      user_id
    end
  end
end
