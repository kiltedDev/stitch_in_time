require 'rails_helper'

RSpec.describe Punch, type: :model do
  before(:each) do
    @bob = create(:user)
    @skunk_works = create(:project)
    @comet_day = create(:punch, comment: "Threw comets at Ragnarok")
  end

  it "is a valid model" do
    expect(@comet_day).to be_valid
  end

  it "is not valid without an in_time" do
    @comet_day.time_in = nil
    expect(@comet_day).to_not be_valid
  end

  it "is not valid without an attached project" do
    @comet_day.project_id = nil
    expect(@comet_day).to_not be_valid
  end

  it "is is delegated to the user who own the project" do
    expect(@comet_day.user).to eq @bob
  end

  it "is destoyed when its project is" do
    expect(Punch.count).to eq(1)
    @skunk_works.destroy
    expect(Punch.count).to eq(0)
  end

  it "is destoyed when its project's user is" do
    expect(Punch.count).to eq(1)
    @bob.destroy
    expect(Punch.count).to eq(0)
  end
end
