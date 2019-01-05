require 'rails_helper'

feature 'edit project', %(
  As a user, I want to be able to edit my project in case details change.
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")
    login_as @bob
  end

  it 'can update name' do
    visit edit_project_path @deltas
    fill_in "project[name]", with: "Cohabitate with Deltans"
    click_button "Update"

    expect(page).to have_content("Cohabitate with Deltans")
    expect(@deltas.reload.name).to eq("Cohabitate with Deltans")
  end

  it 'can update description' do
    visit edit_project_path @deltas
    fill_in "project[description]", with: "Complete the language studies and the drone body"
    click_button "Update"

    expect(page).to have_content("Complete the language studies and the drone body")
    expect(@deltas.reload.description).to eq("Complete the language studies and the drone body")
  end
end
