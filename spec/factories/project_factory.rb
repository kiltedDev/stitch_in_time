FactoryBot.define do
  factory :project do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    user { User.first}
  end
end
