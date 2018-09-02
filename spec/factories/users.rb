FactoryBot.define do
  factory :user do
    browser_name Faker::Internet.username
    auth_token SecureRandom.hex
  end
end
