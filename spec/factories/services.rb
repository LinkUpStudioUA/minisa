FactoryBot.define do
  factory :service do
    title { Faker::Book.title }
    description { Faker::Quotes::Shakespeare.hamlet_quote }
    price_cents { Faker::Number.number(4) }
    seller
  end
end
