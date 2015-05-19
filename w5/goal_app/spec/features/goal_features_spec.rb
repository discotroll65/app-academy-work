require "rails_helper"



feature 'User can create goals' do
  let(:user){create(:user)}
  let(:user2){create(:user)}
  let(:goal){build(:goal)}

  it 'After Log In User lands on his show page' do
    sign('In', user)

    expect(current_url).to eq(user_url(user))
  end

  it 'Does not show a link to create goal for other users' do
    sign("In", user2)
    visit "/users/#{user.id}"

    expect(page).to_not have_content("Create New Goal")
  end

  feature 'User creates goals from show page' do
    before(:each) do
      sign('In', user)
      click_link("Create New Goal")
    end

    it "redirects user to new_goal path" do
      expect(current_url).to eq(new_goal_url)
    end

    it "Tries again if you have invalid input, keeping the old" do
      fill_in('Body', with: goal.body)
      click_button("Create Goal")

      expect(page).to have_content(goal.body)
      expect(page).to have_content("Title can't be blank")
    end

    it "Creates a goal after filling in fields and clicking button" do
      fill_in('Title', with: goal.title)
      fill_in('Body', with: goal.body)
      click_button("Create Goal")

      expect(current_url).to eq(user_url(user))
      expect(page).to have_content(goal.title)
      expect(page).to have_content('Uncompleted')
      expect(goal.completed).to eq(false)
    end
  end

  feature "Goals are public or private" do
    before(:each) do
      sign('In', user)
      click_link("Create New Goal")
      fill_in('Title', with: goal.title)
      fill_in('Body', with: goal.body)
    end

    it "Public goals can be seen by other users"  do
      choose("Public")
      click_button("Create Goal")

      click_button('Sign Out')
      sign('In', user2)
      visit("users/#{user.id}")
      # two pestatas says you're wrong

      expect(page).to have_content(goal.title)
    end

    it "Private goals can't be seen by other users" do
      choose('Private')
      click_button("Create Goal")

      click_button('Sign Out')
      sign('In', user2)
      visit("users/#{user.id}")
      # two pestatas says you're wrong

      expect(page).to_not have_content(goal.title)
    end
  end
end

feature 'User can edit status of a goal' do
  let(:user) {setup_user_with_goal}
  let(:user2){create(:user)}
  let(:goal){create(:goal)}


  it "User can press the complete button to complete the goal" do
    it "This button is only present to the current_user" do
      sign("In", user2)
      visit "user/#{user.id}"
      click_link("#{goal.title}")

      page.should_not have_selector("input[type=submit][value='Complete!']")

      click_button("Sign Out")
      sign("In", user)

      page.should have_selector("input[type=submit][value='Complete!']")
    end
  end

  it "Edit button is present" do

    it "is not present for other users" do
      sign("In", user2)
      visit "user/#{user.id}"
      click_link("#{goal.title}")

      page.should_not have_selector("input[type=submit][value='Edit Goal']")

      click_button("Sign Out")
      sign("In", user)

      page.should have_selector("input[type=submit][value='Edit Goal']")
    end

    it "User can change goal title" do
      sign("In", user)
      click_link("#{goal.title}")
      click_button("Edit Goal")
      fill_in("Title", with: "I'm a rat")
      click_button("Update Goal")

      expect(current_url).to eq( goal_url(goal) )
      expect(page).to have_content("I'm a rat")
    end

    it "User can edit goal body" do
      sign("In", user)
      click_link("#{goal.title}")
      click_button("Edit Goal")
      fill_in("Body", with: "I'm a rat body")
      click_button("Update Goal")

      expect(current_url).to eq( goal_url(goal) )
      expect(page).to have_content("I'm a rat body")
    end

    it "User can change goal from Private to Public" do
      sign("In", user)
      click_link("#{goal.title}")
      click_button("Edit Goal")
      choose('Public')
      click_button("submit")

      expect(page).to have_content("Public")

      click_button("Sign Out")
      sign_("In", user2)
      visit "user/#{user.id}"
      click_link("#{goal.title}")

      expect(page).to have_content(goal.body)
    end
  end
end

feature "User can delete goal" do
  let(:user) {setup_user_with_goal}
  let(:user2){create(:user)}
  let(:goal){create(:goal)}

  it "Delete button present for goals of current_user" do
    sign("In", user)
    click_link("#{goal.title}")

    page.should have_selector("input[type=submit][value='Delete']")
  end

  it "Delete button not present for goals not owned by current_user" do
    sign("In", user2)
    visit "user/#{user.id}"
    click_link("#{goal.title}")

    page.should_not have_selector("input[type=submit][value='Delete']")
  end

  it "clicking delete button destroys goal" do
    sign("In", user)
    click_link("#{goal.title}")

    click_button("Delete")

    expect(page).to_not have_content(goal.title)
  end
end
