require 'faker'

def elo_points(player_1_score, player_2_score, match)
  difference = player_1_score - player_2_score
  exponent = -(difference / 100.to_f)
  probability = 1.to_f / (1.to_f + (10.to_f ** exponent))

  if player_1_score < 2100.to_f
    k_player_1 = 32.to_f
  elsif player_1_score > 2400.to_f
    k_player_1 = 16.to_f
  else
    k_player_1 = 24.to_f
  end

  if player_2_score < 2100.to_f
    k_player_2 = 32.to_f
  elsif player_2_score > 2400.to_f
    k_player_2 = 16.to_f
  else
    k_player_2 = 24.to_f
  end

  if match.match_result.winner == match.player_1
    s = 1.to_f
  else
    s = 0.to_f
  end

  new_player_1_score = player_1_score + k_player_1 * (s - probability)
  new_player_2_score = player_2_score + k_player_2 * ((1.to_f - s) - (1.to_f - probability))
  return results = [new_player_1_score, new_player_2_score]
end

puts "destroy all"

Favorite.destroy_all
Message.destroy_all
Callout.destroy_all
MatchResult.destroy_all
Match.destroy_all
Event.destroy_all
User.destroy_all
Court.destroy_all
Club.destroy_all

puts "creating clubs"

club_url_1 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1571083490/FC-Barcelona-fc-barcelona-336927_1024_754_mlwy2m.jpg"
club_url_2 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1571083487/RealMadrid_Wallpaper4_urlcnr.jpg"
club_url_3 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1571083484/nuevo-fichaje-de-la-real-sociedad_cnd1m3.jpg"
club_url_4 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1571083480/lisboa_h9qg6j.jpg"
club_url_5 = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1571083474/Visite-du-Parc-des-Princes-Experience-Paris-Saint-Germain-Vue-ae%CC%81rienne-_-630x405-_-_-OTCP-DR_cdkqso.jpg"

Club.create!(
  name: 'FC Barcelona',
  shortname: 'FCB',
  address: "C. d'Arístides Maillol, 12, 08028 Barcelona, España",
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  description: Faker::Lorem.sentence(60),
  website: Faker::Internet.url,
  picture: club_url_1,
  access: "Private, members only"
  )
Club.create!(
  name: 'Real Madrid',
  shortname: 'RM',
  address: 'Av. de Concha Espina, 1, 28036 Madrid, España',
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  description: Faker::Lorem.sentence(60),
  website: Faker::Internet.url,
  picture: club_url_2,
  access: "Semi-private, invitation possible"
  )
Club.create!(
  name: 'Real Sociedad',
  shortname: 'RS',
  address: '1, Anoeta Pasealekua, 20014 Donostia, Gipuzkoa, España',
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  description: Faker::Lorem.sentence(60),
  website: Faker::Internet.url,
  picture: club_url_3,
  access: "Public"
  )
Club.create!(
  name: 'FC Lisboa',
  shortname: 'FCL',
  address: 'Rua Professor Fernando da Fonseca, 1501-806 Lisboa, Portugalia',
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  description: Faker::Lorem.sentence(60),
  website: Faker::Internet.url,
  picture: club_url_4,
  access: "Semi-private, invitation possible"
  )
Club.create!(
  name: 'Paris Saint Germain',
  shortname: 'PSG',
  address: '24 Rue du Commandant Guilbaud, 75016 Paris, Francia',
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  description: Faker::Lorem.sentence(60),
  website: Faker::Internet.url,
  picture: club_url_5,
  access: "Private, members only"
  )

puts "5 clubs created!"

puts "creating courts"

50.times do
  Court.create!(
    name: ["Court 1", "Court 2", "Court 3"].sample,
    surface: ["Clay", "Hard", "Grass", "Carpet"].sample,
    indoor: [false, true].sample,
    lights: [false, true].sample,
    water: [false, true].sample,
    single: [false, true].sample,
    club_id: Club.all.sample.id
    )
end

puts "courts created!"

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
    level: ["beginner", "beginner_plus", "intermediate", "intermediate_plus", "advanced", "advanced_plus", "expert", "expert_plus", "semi_pro", "semi_pro_plus", "pro"].sample,
    bio: Faker::Lorem.sentence(15),
    address: "Barcelona",
    place_of_birth: "#{Faker::Address.city}, #{Faker::Address.country}",
    user_name: "@#{Faker::Lorem.word}",
    style_of_play: ["baseliner", "attacker", "baseliner", "server-volleyer","puncher"].sample,
    gender: Faker::Gender.binary_type.downcase,
    country: Faker::Address.country_code,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    points: rand(500..2000),
    handedness: ["righty","lefty"].sample,
    club_id: Club.all.sample.id,
    backhand_style: ["one_handed_backhand","two_handed_backhand"].sample,
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
    gender: Faker::Gender.binary_type.downcase,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    handedness: ["righty","lefty"].sample,
    club_id: Club.all.sample.id,
    backhand_style: ["one_handed_backhand","two_handed_backhand"].sample,
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
    gender: Faker::Gender.binary_type.downcase,
    ranking: rand(1..1000),
    height: rand(150..200),
    weight: rand(50..100),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    birthday: Faker::Date.birthday(18, 65),
    handedness: ["righty","lefty"].sample,
    club_id: Club.all.sample.id,
    backhand_style: ["one_handed_backhand","two_handed_backhand"].sample,
    status: "active"
    )
  leo.remote_picture_url = "https://res.cloudinary.com/dwvr5h8ps/image/upload/v1559121625/nadal_m7vz84.jpg"
  players << leo

  puts "finsihed creating players"

  puts "creating matches"
  counter = 1

100.times do
  puts "creating match #{counter}"
  counter += 1

  player_1 = edouard
  player_2 = leo

  match = Match.create!(
    date: Date.today-rand(360),
    player_1: player_1,
    player_2: player_2,
    club: Club.all.sample
    )

  set1 = MatchSet.create!(
    match: match,
    player_1_games: rand(0..6),
    player_2_games: rand(0..6)
    )

  if set1.player_2_games == set1.player_1_games
    set1.player_2_games += 1
    set1.save
  end

  set2 = MatchSet.create!(
    match: match,
    player_1_games: rand(0..6),
    player_2_games: rand(0..6)
    )

  if set2.player_2_games == set2.player_1_games
    set2.player_2_games += 1
    set2.save
  end

  if set1.player_1_games > set1.player_2_games && set2.player_1_games > set2.player_2_games
    winner = match.player_1
    loser = match.player_2
  elsif set1.player_1_games < set1.player_2_games && set2.player_1_games < set2.player_2_games
    winner = match.player_2
    loser = match.player_1
  else
    set3 = MatchSet.create!(
    match: match,
    player_1_games: rand(0..6),
    player_2_games: rand(0..6)
    )

    if set3.player_2_games == set2.player_1_games
      set3.player_2_games += 1
      set3.save
    end

    if set3.player_1_games > set3.player_2_games
      winner = match.player_1
      loser = match.player_2
    else
      winner = match.player_2
      loser = match.player_1
    end
  end

  score = "#{set1.player_1_games}-#{set1.player_2_games} #{set2.player_1_games}-#{set2.player_2_games}"
  score += " #{set3.player_1_games}-#{set3.player_2_games}" if set3

  result = MatchResult.create!(
    match: match,
    winner: winner,
    loser: loser,
    score: score,
    confirmed: true
    )

  points = elo_points(player_1.points, player_2.points, match)
  player_1.update(points: points[0])
  player_2.update(points: points[1])

  # Useless .save since .update is already saving the instance
  # player_1.save
  # player_2.save

  puts "creating reviews"

  comments = ["Had a great time on the tennis court.", "Looking forward to our next Game. This time I'll win.", "It was an intense game but I enjoyed it.", "Was great fun playing agaist you.", "Bad luck with your injury, hope you get well soon.🤕", "Bro, your BACKHAND is sick!!!😎", "It was an amazing match. Same time next week?", "Had a very fun time with you.", "He was not on my level. Smashed him in no time!", "Good match."]

  UserReview.create!(
    sender: match.player_1,
    receiver: match.player_2,
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
    sender: match.player_2,
    receiver: match.player_1,
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

10.times do
  puts "creating event #{counter}"
  counter += 1

  player_1 = edouard
  player_2 = leo

  event = Event.create!(
    date_time: DateTime.tomorrow+rand(360),
    player_1: player_1,
    player_2: player_2,
    club: Club.all.sample
    )
end

10.times do
  puts "creating double event #{counter}"
  counter += 1

  player_1 = edouard
  player_2 = leo

  event = Event.create!(
    date_time: DateTime.tomorrow+rand(360),
    player_1: player_1,
    player_2: player_2,
    player_3: User.where.not("email = ? or email = ?", "a@a.a", "b@b.b").sample,
    player_4: User.where.not("email = ? or email = ?", "a@a.a", "b@b.b").sample,
    club: Club.all.sample
    )
end

puts "Finished seeding"

