FactoryBot.define do
  source = Faker::HarryPotter.book
  factory :analyzed_site do
    url Faker::Internet.url
    hexdigest Digest::SHA1.hexdigest(source)
    source source
  end
end
