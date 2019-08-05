FactoryBot.define do
  factory :match_result do
    match { nil }
    user { nil }
    score { "MyString" }
    confirmed { false }
  end
end
