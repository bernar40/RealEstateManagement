FactoryBot.define do
  factory :property do
    name { Faker::Name.unique.name } # Using Faker for unique property names
    location { Faker::Address.street_address }
    price { Faker::Number.number(digits: 6) }
    status { 'Available' }
  end
end
