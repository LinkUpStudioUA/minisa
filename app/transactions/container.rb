# frozen_string_literal: true

require 'dry/container'
require 'dry/monads/all'

class Container
  extend Dry::Container::Mixin

  M = Dry::Monads

  namespace 'answers' do
    register('create') { Operations::Answers::Create.new }

    register 'transaction_with_seller_lock' do |input, &block|
      result = nil
      ApplicationRecord.transaction do
        input[:params][:service_request].seller.lock!
        result = block.call(M.Success(input))
        raise ActiveRecord::Rollback if result.failure?
      end
      result
    end
  end

  namespace 'requests' do
    register('initialize') { Operations::Requests::Initialize.new }
    register('add_coupon') { Operations::Requests::AddCoupon.new }

    register 'transaction_with_buyer_lock' do |input, &block|
      result = nil
      ApplicationRecord.transaction do
        input[:service_request].buyer.lock!
        result = block.call(M.Success(input))
        raise ActiveRecord::Rollback if result.failure?
      end
      result
    end
  end
end
