# frozen_string_literal: true

require 'dry/transaction/operation'

module Operations
  module Answers
    class Create
      include Dry::Transaction::Operation

      def call(params:)
        service_answer = ServiceAnswer.new(params)

        if service_answer.save
          Success(service_answer: service_answer)
        else
          Failure(service_answer.errors.full_messages)
        end
      end
    end
  end
end
