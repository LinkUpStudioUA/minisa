# frozen_string_literal: true

module Requests
  class Create
    include Dry::Transaction(container: Container)

    step :initialize_request, with: 'requests.initialize'
    step :add_coupon, with: 'requests.add_coupon'
    step :save

    def save(service_request:)
      service_request.save!
      Success(service_request: service_request)
    end
  end
end
