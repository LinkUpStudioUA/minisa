FactoryBot.define do
  factory :coupon do
    promo_code { Faker::Internet.domain_word }
    discount_percentage { 10 }
    expire_at { 5.days.from_now }
  end
end
