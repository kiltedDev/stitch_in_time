FactoryBot.define do
  factory :punch do
    comment { "I am a comment" }
    time_in  { Time.now }
    project { Project.first }
  end
end
