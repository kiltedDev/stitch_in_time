require 'rails_helper'

feature 'project estimates', %(
  As a user, I want to be able to edit my punches in case I forget to punch out, got a late start, or want to comment on the work.
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")
    login_as @bob
    work = Punch.create(time_in: 20.hours.ago, time_out: Time.zone.now, project: @deltas, time_worked: 3600)
    @deltas.tally_cards
  end

  it 'shows the estimate on the project show page' do
    visit project_path @deltas

    expect(page).to have_content("Estimate: $100")
  end

  it 'shows the current rate of pay on the project show page' do
    visit project_path @deltas

    expect(page).to have_content("Rate: $100.00 / hr")
  end

  it "can be modified on the edit page" do
    visit edit_project_path @deltas
    fill_in "project[estimate]", with: 150
    click_button "Update"

    expect(page).to have_content("Estimate: $150")
    expect(page).to have_content("Rate: $150.00 / hr")
    expect(@deltas.reload.estimate).to eq(150)
  end
end
