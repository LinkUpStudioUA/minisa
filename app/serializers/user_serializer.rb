class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :location, :avatar_url, :role

  has_one :balance

  def avatar_url
    object.avatar_url(:thumb)
  end
end
