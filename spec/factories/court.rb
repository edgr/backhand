FactoryBot.define do
  factory :court do
    transient do
      sequence :n
    end

    name { "Court #{n}" }
    surface { "Grass" }
    indoor { true }
    single { true }
    lights { false }
    water { false }
    club { build :club }
  end
end
