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

  it 'user successfully signs in' do
    fill_in :user_email, with: @bob.email
    fill_in :user_password, with: "password"

    click_button 'Log in'

    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Log out')
    expect(page).to_not have_content('Log in')
  end

  it 'a non-existent attempts to sign in' do
    visit new_user_session_path

    fill_in :user_email, with: 'bill@bob.net'
    fill_in :user_password, with: "password"

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Log in')
    expect(page).to_not have_content('Log out')
  end

  it 'an existing user with the wrong password tries to sign in' do
    fill_in :user_email, with: @bob.email
    fill_in :user_password, with: "notmypassword"

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Log in')
    expect(page).to_not have_content('Log out')
  end

  it 'A user cannot sign in when already signed in' do
    medeiros = FactoryBot.create(:user, :major)

    login_as medeiros

    visit new_user_session_path

    expect(page).to have_content('You are already signed in')
  end
end
