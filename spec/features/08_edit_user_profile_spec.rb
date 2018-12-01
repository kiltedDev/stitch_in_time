require 'rails_helper'

feature 'user edit account', %(
  As a user, I want to be able to edit my account.
) do

  before(:each) do
    @bob = create(:user)

    login_as @bob
    visit root_path
    click_link "Settings"
  end

  it 'user fails to enter in correct information' do
    long_string = "a" * 65
    fill_in "Username", with: long_string

    click_button 'Save changes'

    expect(page).to have_content "Invalid username: too long"
    expect(page).to_not have_content "Password can't be blank"
  end

  it 'user fails to enter in correct information' do
    fill_in "Username", with: "a"

    click_button 'Save changes'

    expect(page).to have_content "Invalid username: too short"
    expect(page).to_not have_content "Password can't be blank"
  end

  it 'user edits profile correctly' do
    fill_in "Username", with: "Robert Johansson"

    click_button 'Save changes'

    expect(@bob.reload.username).to eq "Robert Johansson"
    expect(page).to have_content "Profile updated"
    expect(page).to_not have_content "Name can't be blank"
    expect(page).to_not have_content "Password can't be blank"
  end

  it 'redirects edit when not logged in' do
    click_link "Log out"
    visit edit_user_path @bob

    expect(page).to have_content("You need to sign in or sign up before continuing.")
    # expect(page).to have_current_path(login_path)
  end
end
