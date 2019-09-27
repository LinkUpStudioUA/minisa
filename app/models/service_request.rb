# frozen_string_literal: true

class ServiceRequest < ApplicationRecord
  include VideoUploader::Attachment.new(:video)

  extend Enumerize

  enumerize :status, in: %i[
    unsubmitted submitted denied answered canceled
  ]

  belongs_to :buyer, class_name: :User
  belongs_to :service
  belongs_to :coupon, optional: true
  has_one :service_answer, dependent: :destroy
  has_one :seller, through: :service

  validates :text, presence: true

  def could_be_canceled?
    status.submitted? && updated_at > 7.days.ago
  end
end
