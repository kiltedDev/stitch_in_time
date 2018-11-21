require 'rails_helper'

feature 'sign in', %(
  As a user
  I want to sign in
  So that I can submit roll some dice
) do

  before(:each) do
    @bob = create(:user)
    visit login_path
  end

  scenario 'user successfully signs in' do
    fill_in 'Email', with: @bob.email
    fill_in 'Password', with: "password"

    click_button 'Log in'

    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Log out')
    expect(page).to_not have_content('Log in')
  end

  scenario 'a non-existent attempts to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'bill@bob.net'
    fill_in 'Password', with: "password"

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Log in')
    expect(page).to_not have_content('Log out')
  end

  scenario 'an existing user with the wrong password tries to sign in' do
    fill_in 'Email', with: @bob.email
    fill_in 'Password', with: "notmypassword"

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Log in')
    expect(page).to_not have_content('Log out')
  end

  scenario 'A user cannot sign in when already signed in' do
    medeiros = FactoryBot.create(:user, :major)

    login_as(medeiros, scope: :user)

    visit new_user_session_path

    expect(page).to have_content('You are already signed in')
  end
end
