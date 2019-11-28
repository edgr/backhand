FactoryBot.define do
  factory :court do
    name { "MyString" }
    surface { "MyString" }
    indoor { false }
    single { false }
    lights { false }
    water { false }
  end
end
