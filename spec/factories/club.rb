FactoryBot.define do
  factory :club do
    transient do
      sequence :n
    end

    name { "Club de Tenis Barcelona #{n}" }
    shortname { "Barcelona #{n}" }
    address { "Camí de Pau Redó, 10, 08908 L'Hospitalet de Llobregat, Barcelona" }
    email { "club#{n}@example.com" }
    phone_number { "34 111 333 311" }
  end
end
