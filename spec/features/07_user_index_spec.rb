require 'rails_helper'

feature 'user edit account', %(
  As a user, I want to be able to edit my account.
) do

  before(:each) do
    @bob = create(:user)
    26.times do |n|
      n+= 65
      create(:user, name: "Agent Smith#{n.chr}", email: "Smith#{n.chr}@matrix.io")
      create(:user, name: "Agent Smith#{n.chr}#{n.chr}", email: "Smith#{n.chr}#{n.chr}@matrix.io")
    end
  end

  scenario 'redirects to login in order to view index when logged out' do
    visit users_path

    expect(page).to have_current_path(login_path)
  end

  scenario 'shows paginated index of users' do
    last_agent = User.last

    log_in_as @bob
    visit users_path

    User.paginate(page: 1).each do |user|
      expect(page).to have_link(user.name)
    end
    expect(page).to_not have_link(last_agent.name)
  end

  scenario 'has two links for pagination' do
    log_in_as @bob
    visit users_path

    expect(page).to have_link("2", count: 2)
  end

end
