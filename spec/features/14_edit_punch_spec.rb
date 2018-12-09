require 'rails_helper'

feature 'edit punches', %(
  As a user, I want to be able to edit my punches in case I forget to punch out, got a late start, or want to comment on the work.
) do

  before(:each) do
    @bob = create(:user)
    @deltas = create(:project, name: "The Deltas", description: "Totally violating the prime directive.")
    @archimedes = create(:punch)
    @drone = create(:punch, :finished)
    login_as @bob
  end

  it 'redirects to the punch out page if active' do
    visit user_path @bob
    find('.clickable-text', text: 'The Deltas').click

    expect(current_path).to eq "/projects/1"
  end

  it 'lets the user adjust the comment of the punch' do
    visit edit_punch_path @drone
    new_comment = "A drone to fight Gorilloids with"

    fill_in "Comment", with: new_comment
    click_button "Save task"

    expect(@drone.reload.comment).to eq(new_comment)
  end

  it 'shows the time worked on this punch' do
    i = Time.zone.now - 1.hours
    o = Time.zone.now - 30.minutes
    knapping = create(:punch, time_in: i, time_out: o )
    knapping.adjust_time
    visit edit_punch_path knapping

    expect(page).to have_content("30 minutes")
  end

  it 'lets the user adjust the time in of the punch' do
    visit edit_punch_path @drone
    new_time_in = Time.zone.now
    h = "#{new_time_in.strftime("%I")} #{new_time_in.strftime("%p")}"

    select(h, from: 'punch[time_in(4i)]')
    select(new_time_in.strftime("%M"), from: 'punch[time_in(5i)]')
    click_button "Save task"

    expect(@drone.reload.time_in.hour).to eq(new_time_in.hour)
    expect(@drone.reload.time_in.min).to eq(new_time_in.min)
  end

  it 'lets the user adjust the time out of the punch' do
    visit edit_punch_path @drone
    new_time_out = Time.zone.now
    h = "#{new_time_out.strftime("%I")} #{new_time_out.strftime("%p")}"

    select(h, from: 'punch[time_out(4i)]')
    select(new_time_out.strftime("%M"), from: 'punch[time_out(5i)]')
    click_button "Save task"

    expect(@drone.reload.time_out.hour).to eq(new_time_out.hour)
    expect(@drone.reload.time_out.min).to eq(new_time_out.min)
  end

  pending "remove 'if' from punches controller @pretty_time"
end
