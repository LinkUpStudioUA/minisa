# frozen_string_literal: true

class ServiceRequestPolicy < ApplicationPolicy
  def create?
    user.role.buyer?
  end

  def cancel?
    service_request.could_be_canceled? && service_request.buyer_id == user.id
  end

  def submit?
    service_request.buyer_id == user.id
  end

  def answer?
    service_request.status.submitted? && service_request.service.seller_id == user.id
  end

  def deny?
    service_request.service.seller_id == user.id
  end

  private

  def service_request
    record
  end
end
