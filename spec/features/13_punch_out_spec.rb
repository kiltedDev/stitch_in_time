require 'rails_helper'

feature 'can punch out', %(
  As a user, I want to be able to end a task I'm working on.
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")
    @archimedes = create(:punch, comment: "Teach Archimedes")

    login_as @bob
    visit project_path @deltas
  end

  it 'sees punch out button' do
    find('.clickable-text', text: @archimedes.comment).click

    expect(page).to have_css('.btn-danger')
  end

  it 'punching out makes punch inactive and fills time out' do
    find('.clickable-text', text: @archimedes.comment).click
    click_button 'punch-out'

    expect(@deltas.punches.first.active?).to be false
    expect(@deltas.punches.first.time_out).to_not be nil
  end
end
