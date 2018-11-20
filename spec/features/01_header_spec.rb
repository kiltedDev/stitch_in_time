require 'rails_helper'

feature 'navigation', %(
  As a user, I want to click on links and have them go to not the wrong place.
) do
  before(:each) do
    visit root_path
  end

  scenario 'header should have correct links' do

    expect(page).to have_link("stitch in time", href: root_path)
    expect(page).to have_link("Home", href: root_path)
    expect(page).to have_link("Help", href: help_path)
    # expect(page).to have_link("Log in", href: login_path)

  end
end
