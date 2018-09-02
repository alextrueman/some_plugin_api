class User < ApplicationRecord
  has_many :user_analyzed_sites
  has_many :analyzed_sites, through: :user_analyzed_sites

  validates_presence_of :browser_name, :auth_token
end
