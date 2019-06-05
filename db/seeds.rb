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
url = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559121625/djokovic_hxcpm8.jpg"
5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
    phone_number: Faker::Number.number(12),
    level: ["pro", "beginner", "intermediate","advanced","semi-pro"].sample,
    bio: Faker::Lorem.sentence(15),
    address: "Barcelona",
    place_of_birth: "#{Faker::Address.city}, #{Faker::Address.country}",
    user_name: "@#{Faker::Lorem.word}",
    style_of_play: ["baseliner", "attacker", "baseliner","server-volleyer","puncher"].sample,
    gender: Faker::Gender.binary_type,
    country: Faker::Address.country,
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

  max = User.create!(
    first_name: 'Max',
    last_name: 'Mustermann',
    email: 'a@a.a',
    phone_number: '12345678912',
    level: 'pro',
    password: 'password',
    points: 1200,
    country: 'Germany',
    bio: Faker::Lorem.sentence(15),
    address: "Barcelona",
    place_of_birth: "#{Faker::Address.city}, #{Faker::Address.country}",
    user_name: "@#{Faker::Lorem.word}",
    style_of_play: ["baseliner", "attacker", "baseliner","server-volleyer","puncher"].sample,
    gender: Faker::Gender.binary_type,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    handedness: ["righty","lefty"].sample,
    backhand_style: ["one handed backhand","two handed backhand"].sample
    )
  max.remote_picture_url = url
  max.save

  bob = User.create!(
    first_name: 'Bob',
    last_name: 'Sponge',
    email: 'b@b.b',
    address: 'Barcelona',
    phone_number: '12345678912',
    level: 'pro',
    password: 'password',
    points: 1150,
    country: 'Germany',
    bio: Faker::Lorem.sentence(15),
    place_of_birth: "#{Faker::Address.city}, #{Faker::Address.country}",
    user_name: "@#{Faker::Lorem.word}",
    style_of_play: ["baseliner", "attacker", "baseliner","server-volleyer","puncher"].sample,
    gender: Faker::Gender.binary_type,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    handedness: ["righty","lefty"].sample,
    backhand_style: ["one handed backhand","two handed backhand"].sample
    )
  bob.remote_picture_url = url
  bob.save

  challenge = Challenge.create!(
    challenger_id: max.id,
    challengee_id: bob.id,
    status: "Pending"
    )

  UserReview.create!(
    sender_id: max.id,
    receiver_id: bob.id,
    challenge_id: challenge.id,
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
