# frozen_string_literal: true

class ServiceAnswer < ApplicationRecord
  include VideoUploader::Attachment.new(:video)

  belongs_to :service_request
  has_one :service, through: :service_request

  validates :text, presence: true
end
