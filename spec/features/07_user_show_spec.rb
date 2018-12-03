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

  it "shows index of user's projects, most recently worked first" do
    10.times do
      name = Faker::Lorem.sentence(8)
      description = Faker::Lorem.sentence(10)
      create(:project, user: @bob, name: name, description: description)
    end
    first = Project.find(4)
    p = create(:punch, project: first)
    first.check_card

    visit user_path @bob
    expect(page).to have_content("#{first.name}\n#{Project.second.name}")
  end
end
