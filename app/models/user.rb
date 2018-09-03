class User < ApplicationRecord
  has_many :user_analyzed_sites
  has_many :analyzed_sites, through: :user_analyzed_sites

  before_validation :generate_access_token

  validates_presence_of :browser_name, :auth_token

  private

  def generate_access_token
    self.auth_token = SecureRandom.hex unless auth_token
  end
end
