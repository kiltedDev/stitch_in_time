require 'rails_helper'

feature 'project estimates', %(
  As a user, I want to be able to edit my punches in case I forget to punch out, got a late start, or want to comment on the work.
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")
  end

  it 'shows on the project show page' do
    visit project_path @deltas

    expect(page).to have_content("Estimate: 100")
  end

  it "can be modified on the edit page" do
    visit edit_project_path @deltas
    fill_in "project[estimate]", with: 150
    click_button "Update"

    expect(page).to have_content("Estimate: 150")
    expect(@deltas.reload.estimate).to eq(150)
  end
end
