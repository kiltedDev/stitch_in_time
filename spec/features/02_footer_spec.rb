require 'rails_helper'

feature 'navigation', %(
  As a user, I want to click on links and have them go to not the wrong place.
) do
  before(:each) do
    visit root_path
  end

  it 'Footer should have correct links' do
    # expect(page).to have_link("Thomas Wilson", href: "http://www.railstutorial.org/")
    expect(page).to have_link("About", href: about_path)
    expect(page).to have_link("Contact", href: contact_path)
    expect(page).to have_link("News", href: "https://crooked.com/podcast-series/pod-save-america/")
  end
end
