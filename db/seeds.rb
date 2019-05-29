# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all

puts "creating users"
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
    picture: Faker::Avatar.image,
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
  user.save!
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

  UserReview.create!(
    sender_id:21,
    receiver_id:1,
    challenge_id:1,
    content: "was fun playing",
    serve: 5,
    return: 5,
    backhand: 5,
    forehand: 5,
    volley: 5,
    speed: 5,
    power: 5,
    endurance:5,
    thumb: true
    )

puts "Finished creating users"
