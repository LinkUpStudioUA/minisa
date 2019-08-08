# frozen_string_literal: true

class ServicePolicy < ApplicationPolicy
  def create?
    user.role.seller?
  end

  def update?
    user.id == service.seller_id
  end

  def destroy?
    user.id == service.seller_id
  end

  private

  def service
    record
  end
end
