FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    price Faker::Number.number
  end
end
