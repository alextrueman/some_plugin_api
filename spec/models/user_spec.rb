require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:browser_name) }
  it { is_expected.to validate_presence_of(:auth_token) }
end
