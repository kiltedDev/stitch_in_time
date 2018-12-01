FactoryBot.define do
  factory :punch do
    comment { "I am a comment" }
    time_in  { Time.now }
    project { Project.first }
  end

  trait :finished do
    comment { "I am complete" }
    time_in { Time.now - 2.hours}
    time_out { Time.now - 1.hours}
  end
end
