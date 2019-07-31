FactoryBot.define do
  factory :user do
    email { "joe@gmail.com" }
    password { "blahblah" }
    phone_number { "123456789789"}
  end
end
