FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "blahblah" }
    phone_number { "123456789789" }
  end
end
