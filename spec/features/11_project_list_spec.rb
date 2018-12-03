require 'rails_helper'

feature 'show projects page', %(
  As a user, view a list of my projects.
) do

  before(:each) do
    @bob = create(:user)
    10.times do
      name = Faker::Lorem.sentence(8)
      description = Faker::Lorem.sentence(10)
      create(:project, user: @bob, name: name, description: description)
    end

    login_as @bob
  end

  it 'see a list of my projects' do
    third = @bob.projects.third
    p = create(:punch, project: third)
    third.check_card

    visit projects_path @bob
    expect(page).to have_content @bob.nickname
    expect(page).to have_content @bob.projects.first.name
    expect(page).to have_content @bob.projects.second.name
  end

end
