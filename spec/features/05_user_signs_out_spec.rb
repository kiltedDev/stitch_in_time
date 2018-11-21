require 'rails_helper'

feature 'user signs out', %Q{
  As a user
  I want to be able to sign out
} do

  scenario 'an existing user specifies a valid email and password' do
    bob = FactoryBot.create(:user)
    login_as(bob, :scope => :user)

    visit new_user_session_path

    click_link 'Log out'

    expect(page).to have_content("We'll miss you.")
    expect(page).to have_content("Log in")
  end
end
