require 'rails_helper'

feature 'sign up', %(
  As an unauthenticated user
  I want to sign up
  So that I can track projects
) do

  scenario 'specifying valid and required information' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    user = User.first

    expect(user.email).to eq('user@example.com')
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Log out")
  end

  scenario 'required information is not supplied' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to_not have_content("Log out")
  end

  scenario 'email is not unique' do
    bob = FactoryBot.create(:user)
    visit new_user_registration_path

    fill_in 'Email', with: bob.email
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content("Email has already been taken")
    expect(page).to_not have_content("Log out")
  end

  scenario 'password confirmation does not match confirmation' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'somethingDifferent'

    click_button 'Sign up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Log out")
  end
end
