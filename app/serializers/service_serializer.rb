class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :seller
  has_one :price
end
