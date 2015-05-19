require 'spec_helper'
require 'rails_helper'
# require 'user_factory'

feature 'the sign up process' do
  let(:user) {build(:user)}

  it 'has a new user page' do
    visit('users/new')
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do
    it 'shows username on the homepage after signup' do
      sign("Up", user)
      expect(page).to have_content(user.username)
    end
  end
end

feature 'logging in' do
  let(:user) {build(:user)}
  
  it 'shows username on the homepage after loggin' do
    sign("Up", user)
    sign("In", user)
    expect(page).to have_content(user.username)
  end

  feature 'logging out' do
    it 'begins with logged out state' do
      visit('session/new')
      expect(page).not_to have_content(user.username)
    end

    it 'does not show username on the homepage after log out' do
      sign("Up", user)
      sign("In", user)
      click_button("Sign Out")
      expect(page).not_to have_content(user.username)
    end
  end
end
