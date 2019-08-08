# frozen_string_literal: true

module Answers
  class Create
    include Dry::Transaction(container: Container)

    around :db_transaction, with: 'answers.transaction_with_seller_lock'

    step :create, with: 'answers.create'
    step :update_seller
    step :update_request

    def update_seller(service_answer:)
      service_request = service_answer.service_request
      seller = service_request.seller
      seller.balance += service_request.service.price_with_discount(seller.commission_percentage)
      if seller.save
        Success(service_answer: service_answer)
      else
        Failure(seller.errors.full_messages)
      end
    end

    def update_request(service_answer:)
      service_answer.service_request.update!(status: :answered)
      Success(service_answer: service_answer)
    end
  end
end
