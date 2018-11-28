require 'rails_helper'

feature 'show project page', %(
  As a user, view individual projects.
) do

  before(:each) do
    @bob = create(:user)
    @skunk_works = create(:project)

    login_as @bob
    visit project_path @skunk_works
  end

  scenario 'shows project details' do
    expect(page).to have_content @skunk_works.name
    expect(page).to have_content @skunk_works.description
  end

  scenario 'lists punches in order from newest to oldest' do
    t = Time.now
    15.times do |n|
      start_time = (t - (n*2).minutes)
      end_time = (start_time + 10.minutes)
      oldest = create(:punch, time_in: start_time, time_out: end_time)
    end
    newest = create(:punch, time_in: t + 10.minutes)
    debugger

    expect(page).to have_link newest.time_in.pretty
    expect(page).to_not have_link oldest.time_in.pretty
  end
end
