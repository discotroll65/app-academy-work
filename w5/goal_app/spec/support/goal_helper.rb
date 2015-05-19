def setup_user_with_goal
  user = create(:user)
  user.goals << build(:goal)
  user
end
