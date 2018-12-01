require 'rails_helper'

feature 'can punch in', %(
  As a user, I want to be able to punch into a task
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")

    login_as @bob
    visit project_path @deltas
  end

  it 'sees punch in button' do
    expect(page).to have_button 'punch-in'
  end

  it 'punching in makes new punch' do
    expect(@deltas.punches.count).to eq(0)
    click_button 'punch-in'

    expect(@deltas.punches.count).to eq(1)
  end
end
