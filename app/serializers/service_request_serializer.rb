class ServiceRequestSerializer < ActiveModel::Serializer
  attributes :id, :text, :video_url

  belongs_to :buyer
  belongs_to :service, serializer: ServiceSerializer
  has_one :service_answer
end
