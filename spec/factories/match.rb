FactoryBot.define do
  factory :match do
    player_1 { FactoryBot.create(:user) }
    player_2 { FactoryBot.create(:user) }
    score { "63 64" }
    date { "24-05-2019" }
    location { "La Salut" }
    winner { "Bobby" }
    loser { "Jacky" }
  end
end
