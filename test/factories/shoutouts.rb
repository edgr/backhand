FactoryBot.define do
  factory :shoutout do
    recipients { false }
    minimum_level { 1 }
    message { "MyString" }
    user { nil }
  end
end
