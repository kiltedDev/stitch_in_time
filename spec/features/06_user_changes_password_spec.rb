require 'rails_helper'

feature 'change password', %(
  As a user, I want to be able to change my password.
) do

  before(:each) do
    @bob = create(:user)

    login_as @bob
    visit edit_user_registration_path
  end

  scenario 'user fails to enter in correct information' do
    fill_in "Password", with: ""

    click_button 'Update'

    expect(page).to_not have_content "Password can't be blank"
    expect(@bob.reload.email).to eq("thebob@bob.net")
  end

  scenario 'user changes profile correctly' do
    fill_in "Password", with: "iamthebob"
    fill_in "Password confirmation", with: "iamthebob"
    fill_in "Current password", with: "password"

    click_button 'Update'

    expect(page).to have_content "Your account has been updated successfully."
  end

  scenario 'redirects edit when not logged in' do
    click_link "Log out"
    visit edit_user_registration_path @bob

    expect(page).to have_content("You need to sign in or sign up before continuing.")
    # expect(page).to have_current_path(login_path)
  end
end
