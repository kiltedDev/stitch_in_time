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
    40.times do |n|
      name = Faker::Lorem.sentence(8)
      description = Faker::Lorem.sentence(10)
      create(:project, user: @bob, name: name, description: description)
    end
    first_project = @bob.projects[0]
    last_project = create(:project, user: @bob, name: "I am the last project")
    # debugger
    visit user_path @bob
    expect(page).to have_link(last_project.name)
    expect(page).to_not have_link(first_project.name)
  end

  scenario "has pagination links" do
    expect(page).to have_link("2", count: 2)
  end

end
