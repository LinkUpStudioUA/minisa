# frozen_string_literal: true

class User < ApplicationRecord
  include AvatarUploader::Attachment.new(:avatar)
  extend Enumerize

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PASSWORD_LENGTH = (8...72).freeze

  has_secure_password

  enumerize :role, in: %i[buyer seller admin], scope: true

  monetize :balance_cents

  has_many :services, foreign_key: :seller_id, dependent: :destroy
  has_many :service_requests, foreign_key: :buyer_id, dependent: :destroy

  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX },
            if: -> { email.present? }
  validates :password_digest, :role, presence: true
  validates :password, confirmation: true, length: {
    in: VALID_PASSWORD_LENGTH, allow_nil: true, allow_blank: true
  }, if: -> { password.present? }
  validates :name, presence: true, length: { maximum: 80 }, uniqueness: true
  validates :balance_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :commission_percentage, presence: true, if: -> { role.seller? }

  scope :by_name, ->(name) {
    where(arel_table[:name].matches("%#{name}%"))
  }
end
