class UserSerializer < ActiveModel::Serializer
  attributes :username, :bio, :image_url
  has_many :recipes
end
