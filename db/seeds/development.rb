# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  username:  "The Bob",
  email: "thebob@bob.net",
  password:              "password",
  password_confirmation: "password",
)

99.times do |n|
  username  = Faker::Internet.username(8)
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    username:  username,
    email: email,
    password:              password,
    password_confirmation: password,
  )
end

# create projects
users = User.order(:created_at).take(6)
50.times do
  name = Faker::Lorem.sentence(3)
  description = Faker::Lorem.sentence(8)
  users.each { |user| user.projects.create!(name: name, description: description) }
end

# create punches
u = User.first
r = Project.create(user:u, name: "Ragnarok", description: "Making a habitable planet for the remaining humans")
t = Time.now
errands = [
  "Move Comets",
  "Freak out when a comet comes in way too fast",
  "Seed Algae",
  "Build Help",
  "Seed Oceans",
  "Seed insects",
  "Seed animals",
  "Test Bullwinkle",
  nil,
  nil,
  "Build more help",
  nil,
  nil,
  "Build Infrastructure",
  "Build Housing",
  "Build more help",
  "Start Automated Farms",
  "Import Humans",
]
errands.each_with_index do |errand, n|
  i = t - n.days
  o = i + 10.hours
  w = o - i
  p = Punch.create(project: r, time_in: i, time_out: o, comment: errand, time_worked: w)
end
