require 'rails_helper'

feature 'user show page', %(
  As a user, I want to be able to view my profile.
) do

  before(:each) do
    @bob = create(:user, username:"")
    login_as @bob
    visit user_path @bob
  end

  it 'lists user name' do
    expect(page).to have_content(@bob.username)
  end

  it 'lists user email when no username' do
    nobody = create(:user, :nobody)
    login_as nobody
    visit user_path nobody
    expect(page).to have_content(nobody.email)
  end

  it "shows index of user's projects, most recent first" do
    10.times do
      name = Faker::Lorem.sentence(8)
      description = Faker::Lorem.sentence(10)
      create(:project, user: @bob, name: name, description: description)
    end
    next_project = create(:project, user: @bob, name: "I am the penultimate project")
    last_project = create(:project, user: @bob, name: "I am the last project")

    visit user_path @bob
    expect(page).to have_content("#{last_project.name}\n#{next_project.name}")
  end

  pending "adjust #{__FILE__} to list projects by most recently worked on"
end
