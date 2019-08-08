# frozen_string_literal: true

class Coupon < ApplicationRecord
  has_many :service_requests, dependent: :destroy

  validates :promo_code, :discount_percentage, :expire_at, presence: true

  def expired?
    expire_at < Time.current
  end
end
