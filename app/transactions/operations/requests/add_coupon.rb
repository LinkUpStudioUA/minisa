# frozen_string_literal: true

require 'dry/transaction/operation'

module Operations
  module Requests
    class AddCoupon
      include Dry::Transaction::Operation

      def call(service_request:, promo_code: nil)
        return Success(service_request: service_request) unless promo_code

        if (coupon = Coupon.find_by(promo_code: promo_code)) && !coupon.expired?
          service_request.coupon = coupon
          Success(service_request: service_request)
        else
          Failure(['Promocode is not valid'])
        end
      end
    end
  end
end
