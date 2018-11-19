require 'rails_helper'
RSpec.describe "static_pages", type: :view do
    before(:each) do
      @base_title = "Stitch in Time"
    end

  feature "root" do
    scenario "directs to home" do
      visit root_path

      expect(page).to have_content "Stitch in Time"
    end
  end

  feature "home page" do
    scenario "shows home page and link to sources" do
      visit home_path

      expect(page).to have_content "Stitch in Time"
      expect(page).to have_link "Atelier Oliphant"
    end

    scenario "has a title" do
      visit home_path
      expect(page).to have_title "#{@base_title}"
    end

  end

  feature "help page" do
    scenario "show help page with helpful resources" do
      visit help_path

      expect(page).to have_content "Help"
    end

    scenario "has a title" do
      visit help_path

      expect(page).to have_title "Help | #{@base_title}"
    end
  end

  feature "about page" do
    scenario "shows about page with useful information" do
      visit about_path

      expect(page).to have_content "About"
    end

    scenario "has a title " do
      visit about_path

      expect(page).to have_title "About | #{@base_title}"
    end
  end

  feature "contact page" do
    scenario "shows contact page with some people" do
      visit contact_path

      expect(page).to have_content "Contact"
      expect(page).to have_link "Thomas Wilson"
    end

    scenario "has a title" do
      visit contact_path

      expect(page).to have_title "Contact | #{@base_title}"
    end
  end
end
