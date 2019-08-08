# frozen_string_literal: true

class Service < ApplicationRecord
  monetize :price_cents

  belongs_to :seller, class_name: :User
  has_many :service_requests, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }

  def price_with_discount(percent)
    price * (1 - ((percent || 100) / 100))
  end
end
