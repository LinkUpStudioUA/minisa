# frozen_string_literal: true

module Answers
  class Create
    include Dry::Transaction(container: Container)

    around :db_transaction, with: 'answers.transaction_with_seller_lock'

    step :create, with: 'answers.create'
    step :update_seller
    step :update_request

    def update_seller(service_answer:)
      # TODO: implement
      Success(service_answer: service_answer)
    end

    def update_request(service_answer:)
      service_answer.service_request.update!(status: :answered)
      Success(service_answer: service_answer)
    end
  end
end
