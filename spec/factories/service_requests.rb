FactoryBot.define do
  factory :service_request do
    text { Faker::Book.title }
    service
    buyer
    status { :unsubmitted }
  end
end
