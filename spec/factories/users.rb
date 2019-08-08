require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '12345678' }
    balance_cents { Faker::Number.number(6) }
  end

  factory :buyer, parent: :user do
    role { 'buyer' }
  end

  factory :seller, parent: :user do
    role { 'seller' }
    commission_percentage { 18 }
  end
end
