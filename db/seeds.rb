# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
ComputedSkillsSet.destroy_all

puts "creating users"
url = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559121625/djokovic_hxcpm8.jpg"
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
    phone_number: Faker::Number.number(12),
    level: ["pro", "beginner", "intermediate","advanced","semi-pro"].sample,
    bio: Faker::Lorem.sentence(15),
    address: Faker::Address.full_address,
    place_of_birth: "#{Faker::Address.city}, #{Faker::Address.country}",
    user_name: "@#{Faker::Lorem.word}",
    style_of_play: ["baseliner", "attacker", "baseliner","server-volleyer","puncher"].sample,
    gender: Faker::Gender.binary_type,
    nationality: Faker::Nation.nationality,
    picture: ["image/upload/v1559135396/tesurlfse9em5ngtdd7c.png"].sample,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    points: rand(500..2000),
    handedness: ["righty","lefty"].sample,
    backhand_style: ["one handed backhand","two handed backhand"].sample
    )
    user.remote_picture_url = url
    user.save
end

  User.create!(
    first_name: 'Max',
    last_name: 'Mustermann',
    email: 'a@a.a',
    address: 'frankfurt',
    phone_number: '12345678912',
    level: 'pro',
    password: 'password'
    )

puts "Finished creating users"
