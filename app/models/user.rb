class User < ApplicationRecord
  validates_presence_of :browser_name, :auth_token
end
