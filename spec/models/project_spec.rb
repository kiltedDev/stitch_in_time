require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:each) do
    @bob = create(:user)
    @project = create(:project, user: @bob)
  end

  it "is a valid model" do
    expect(@project).to be_valid
  end

  it "is not a valid model without a user" do
    @project.user_id = nil
    expect(@project).to_not be_valid
  end

  it "is not a valid model without a name" do
    @project.name = nil
    expect(@project).to_not be_valid
  end

  it "is not a valid model with a repeated name" do
    project2 = create(:project, user: @bob)
    expect(project2).to be_valid

    project2.name = @project.name
    expect(project2).to_not be_valid
  end

  it "is not a valid model without a description" do
    @project.description = nil
    expect(@project).to_not be_valid
  end

  it "is sorted with most recently worked first" do
    10.times do |n|
      create(:project, user: @bob, created_at: n.hours.ago)
    end
    most_recent = Project.fourth
    p = create(:punch, project: most_recent)
    most_recent.check_card

    expect(Project.first).to eq(most_recent)
  end

  it "is destoyed when its user is" do
    expect(Project.count).to eq(1)
    @bob.destroy
    expect(Project.count).to eq(0)
  end
end
