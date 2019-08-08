# frozen_string_literal: true

require 'dry/container'
require 'dry/monads/all'
include Dry::Monads

class Container
  extend Dry::Container::Mixin

  namespace 'answers' do
    register 'create' do Operations::Answers::Create.new end

    register 'transaction_with_seller_lock' do |input, &block|
      result = nil
      ApplicationRecord.transaction do
        input[:params][:service_request].seller.lock!
        result = block.(Success(input))
        raise ActiveRecord::Rollback if result.failure?
      end
      result
    end
  end

  namespace 'requests' do
    register 'initialize' do Operations::Requests::Initialize.new end
    register 'add_coupon' do Operations::Requests::AddCoupon.new end

    register 'transaction_with_buyer_lock' do |input, &block|
      result = nil
      ApplicationRecord.transaction do
        input[:service_request].buyer.lock!
        result = block.(Success(input))
        raise ActiveRecord::Rollback if result.failure?
      end
      result
    end
  end
end
