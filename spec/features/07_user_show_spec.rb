require 'rails_helper'

feature 'user show page', %(
  As a user, I want to be able to view my profile.
) do

  before(:each) do
    @bob = create(:user, username:"")
    login_as @bob
    visit user_path @bob
  end

  scenario 'lists user name' do
    expect(page).to have_content(@bob.username)
  end

  scenario 'lists user email when no username' do
    nobody = create(:user, :nobody)
    login_as nobody
    visit user_path nobody
    expect(page).to have_content(nobody.email)
  end

  scenario "shows paginated index of user's projects, most recent first" do

  end

  scenario "has pagination links" do

  end

end
