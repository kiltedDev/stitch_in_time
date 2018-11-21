FactoryBot.define do
  factory :user do
    email  { "thebob@bob.net" }
    password { "password" }
  end

  trait :major do
    email { "E.Medeiros@brasil.gov"}
  end

  trait :butterworth do
    email  { "butterworth@bob.net" }
    admin { true }
  end
end
