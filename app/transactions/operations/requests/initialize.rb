# frozen_string_literal: true

require 'dry/transaction/operation'

module Operations
  module Requests
    class Initialize
      include Dry::Transaction::Operation

      def call(params:, **other_args)
        service_request = ServiceRequest.new(params)

        if service_request.valid?
          Success(service_request: service_request, **other_args)
        else
          Failure(service_request.errors.full_messages)
        end
      end
    end
  end
end
