FactoryBot.define do
  factory :service_answer do
    text { Faker::Book.title }
    service_request
  end
end
