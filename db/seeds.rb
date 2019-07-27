require 'faker'

def elo_points(challenger_score, challengee_score, challenge)
  difference = challenger_score - challengee_score
  exponent = -(difference / 100.to_f)
  probability = 1.to_f / (1.to_f + (10.to_f ** exponent))

  if challenger_score < 2100.to_f
    k_challenger = 32.to_f
  elsif challenger_score > 2400.to_f
    k_challenger = 16.to_f
  else
    k_challenger = 24.to_f
  end

  if challengee_score < 2100.to_f
    k_challengee = 32.to_f
  elsif challengee_score > 2400.to_f
    k_challengee = 16.to_f
  else
    k_challengee = 24.to_f
  end

  if challenge.winner == challenge.challenger.id
    s = 1.to_f
  else
    s = 0.to_f
  end

  new_challenger_score = challenger_score + k_challenger * (s - probability)
  new_challengee_score = challengee_score + k_challengee * ((1.to_f - s) - (1.to_f - probability))
  return results = [new_challenger_score, new_challengee_score]
end

puts "destroy all"

User.destroy_all
Club.destroy_all

puts "creating users"

names = ['Monica', 'Nam', 'Juan', 'Carlos', 'Christine', 'Phillip', 'Joel', 'Lukas', 'Jackson', 'Ricardo', 'Meder', 'Cristobal', 'Valentin', 'David', 'Claire', 'Florin', 'Ashley']
url_1 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559819198/federer_x12uh5.png"
url_2 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/miami_hjtjig.jpg"
url_3 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/old_bmnyon.png"
url_4 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/tt_zdowce.jpg"
url_5 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/moya2_begddt.jpg"
url_6 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/Tsitsipas_he9ppn.jpg"
url_7 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818154/Marzorati_tt5i8v.jpg"
url_8 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/feli_w5kvhf.jpg"
url_9 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/murr_oxtvpl.png"
url_10 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/man_pzru52.png"
url_11 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/fede_mbqdpg.png"
url_12 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/kudla_zqgl9i.jpg"
url_13 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/Isner_zatmsu.jpg"
url_14 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/guy_pnt8el.png"
url_15 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/agassi_uiyn8b.png"
url_16 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/Hewitt_erbntf.jpg"
url_17 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818152/agaa_mr40ug.jpg"

pictures = [url_1, url_2, url_3, url_4, url_5, url_6, url_7, url_8, url_9, url_10, url_11, url_12, url_13, url_14, url_15, url_16, url_17]
counter = 0

players = []

17.times do
  puts "creating #{names[counter]}"
  player = User.new(
    first_name: names[counter],
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
    country: Faker::Address.country_code,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    points: rand(500..2000),
    handedness: ["righty","lefty"].sample,
    backhand_style: ["one handed backhand","two handed backhand"].sample,
    status: "active"
    )
  player.remote_picture_url = pictures[counter]
  player.save
  players << player
  counter += 1
end

  edouard = User.create!(
    first_name: 'Edouard',
    last_name: 'Garret',
    email: 'a@a.a',
    phone_number: '34651952237',
    level: 'pro',
    password: 'password',
    points: 1200,
    country: Faker::Address.country_code,
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
    backhand_style: ["one handed backhand","two handed backhand"].sample,
    status: "active"
    )
  edouard.remote_picture_url = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559818153/murrayy_hsuo8c.jpg"
  edouard.save
  players << edouard

  leo = User.create!(
    first_name: 'Leo',
    last_name: 'Siebold',
    email: 'b@b.b',
    address: 'Barcelona',
    phone_number: '01714170663',
    level: 'pro',
    password: 'password',
    points: 1200,
    country: Faker::Address.country_code,
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
    backhand_style: ["one handed backhand","two handed backhand"].sample,
    status: "active"
    )
  leo.remote_picture_url = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559121625/nadal_m7vz84.jpg"
  players << leo

  puts "finsihed creating players"

  puts "creating challenges"
  counter = 1

100.times do
  puts "creating challenge #{counter}"
  counter += 1

  challenger, challengee = players.sample(2)

  challenge = Challenge.create!(
    challenger_id: challenger.id,
    challengee_id: challengee.id,
    status: "pending"
    )

  score = "6:#{rand(1..5)}, 6:#{rand(1..5)}"
  winner = [challenger.id, challengee.id].sample(1)
  if winner == challenger.id
    loser = challengee.id
    winner = challenger.id
  else
    loser = challenger.id
    winner = challengee.id
  end


  challenge.update(
    winner: winner,
    loser: loser,
    score: score,
    status: "played"
    )
  challenge.save

  points = elo_points(challenger.points, challengee.points, challenge)
  challenger.update(points: points[0])
  challengee.update(points: points[1])

  challenger.save
  challengee.save

  puts "creating reviews"

  comments = ["Had a great time on the tennis court.", "Looking forward to our next Game. This time I'll win.", "It was an intense game but I enjoyed it.", "Was great fun playing agaist you.", "Bad luck with your injury, hope you get well soon.🤕", "Bro, your BACKHAND is sick!!!😎", "It was an amazing match. Same time next week?", "Had a very fun time with you.", "He was not on my level. Smashed him in no time!", "Good match."]

  UserReview.create!(
    challenge_id: challenge.id,
    sender_id: challenge.challenger.id,
    receiver_id: challenge.challengee.id,
    content: comments.sample,
    serve: rand(1..10),
    return: rand(1..10),
    backhand: rand(1..10),
    forehand: rand(1..10),
    volley: rand(1..10),
    speed: rand(1..10),
    power: rand(1..10),
    endurance: rand(1..10),
    thumb: [false, true, true].sample
    )

    UserReview.create!(
    challenge_id: challenge.id,
    sender_id: challenge.challengee.id,
    receiver_id: challenge.challenger.id,
    content: comments.sample,
    serve: rand(1..10),
    return: rand(1..10),
    backhand: rand(1..10),
    forehand: rand(1..10),
    volley: rand(1..10),
    speed: rand(1..10),
    power: rand(1..10),
    endurance: rand(1..10),
    thumb: [true, true, false].sample
    )
end

players.each do |player|
  reviews = player.received_reviews
  reviews.each do |review|
    serves = []
    serves << review.serve.to_f
    player.computed_skills_set.serve = serves.inject{ |sum, el| sum + el }.to_f / serves.size

    returns = []
    returns << review.return.to_f
    player.computed_skills_set.return = returns.inject{ |sum, el| sum + el }.to_f / returns.size

    volleys = []
    volleys << review.volley.to_f
    player.computed_skills_set.volley = volleys.inject{ |sum, el| sum + el }.to_f / volleys.size

    forhands = []
    forhands << review.forehand.to_f
    player.computed_skills_set.forehand = forhands.inject{ |sum, el| sum + el }.to_f / forhands.size

    backhands = []
    backhands << review.backhand.to_f
    player.computed_skills_set.backhand = backhands.inject{ |sum, el| sum + el }.to_f / backhands.size

    speeds = []
    speeds << review.speed.to_f
    player.computed_skills_set.speed = speeds.inject{ |sum, el| sum + el }.to_f / speeds.size

    powers = []
    powers << review.power.to_f
    player.computed_skills_set.power = powers.inject{ |sum, el| sum + el }.to_f / powers.size

    endurances = []
    endurances << review.endurance.to_f
    player.computed_skills_set.endurance = endurances.inject{ |sum, el| sum + el }.to_f / endurances.size

    player.save
    player.computed_skills_set.save
  end

    total_size = player.received_reviews.length
    thumbs_up = player.received_reviews.count { |review| review.thumb? }
    player.review_score = (thumbs_up / total_size.to_f) * 100
    player.save

end

puts "creating clubs"

Club.create!(name: 'FC Barcelona')
Club.create!(name: 'Real Madrid')
Club.create!(name: 'Real Sociedad')
Club.create!(name: 'FC Lisboa')
Club.create!(name: 'Paris Saint Germain')
Club.create!(name: 'FC Barcelona')

puts "6 clubs created!"

puts "Finished seeding"

