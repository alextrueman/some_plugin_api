class UserAnalyzedSite < ApplicationRecord
  belongs_to :user
  belongs_to :analyzed_site

  validates_presence_of :user_id, :analyzed_site_id
end
