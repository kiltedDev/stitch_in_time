require 'rails_helper'

feature 'user edit account', %(
  As a user, I want to be able to edit my account.
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

  scenario 'user enters correct information' do
    fill_in :project_name, with: "I am a project"
    fill_in :project_description, with: "I am a very detailed description"

    click_button 'Create'

    expect(page).to have_content "Project created!"
    expect(page).to have_content "I am a project"
    expect(page).to have_content "I am a very detailed description"
    expect(current_path).to eq "/projects/1"
  end
end
