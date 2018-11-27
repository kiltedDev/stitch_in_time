require 'rails_helper'

feature 'show project page', %(
  As a user, view individual projects.
) do

  before(:each) do
    @bob = create(:user)

    login_as @bob
    visit user_path @bob
  end

  scenario 'user fails to enter in correct information' do
    click_button 'Create'

    expect(page).to have_content "Please enter a name"
    expect(page).to_not have_content "Password can't be blank"
  end

  pending "add the specs for punches to #{__FILE__}"
end
