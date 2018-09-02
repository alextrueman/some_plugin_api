require 'rails_helper'

RSpec.describe UserAnalyzedSite, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:analyzed_site_id) }
end
