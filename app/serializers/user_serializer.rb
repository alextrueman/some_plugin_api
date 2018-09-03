class UserSerializer < ActiveModel::Serializer
  attributes :id, :browser_name, :auth_token
end
