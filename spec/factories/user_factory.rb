FactoryBot.define do
  factory :user do
    username { "Bob Johansson" }
    email  { "thebob@bob.net" }
    password { "password" }
  end

  trait :major do
    username { "Major Medeiros" }
    email { "E.Medeiros@brasil.gov"}
  end

  trait :butterworth do
    username { "Col. Butterworth" }
    email  { "butterworth@bob.net" }
  end

  trait :nobody do
    username { "" }
    email  { "nobody@ithaca.edu" }
    password {"goodargos"}
  end
end
