# frozen_string_literal: true

module Requests
  class Submit
    include Dry::Transaction(container: Container)

    around :db_transaction, with: 'requests.transaction_with_buyer_lock'

    step :update_buyer
    step :update_request
    step :add_auto_expiration

    def update_buyer(service_request:)
      buyer = service_request.buyer
      percentage = service_request.coupon&.discount_percentage
      buyer.balance -= service_request.service.price_with_discount(percentage)
      if buyer.save
        Success(service_request: service_request)
      else
        Failure(buyer.errors.full_messages)
      end
    end

    def update_request(service_request:)
      if service_request.update(status: :submitted)
        Success(service_request: service_request)
      else
        Failure(service_request.errors.full_messages)
      end
    end

    def add_auto_expiration(service_request:)
      RequestExpiredWorker.perform_at(1.month.from_now, service_request.id)
      Success(service_request: service_request)
    end
  end
end
