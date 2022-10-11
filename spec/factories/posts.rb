FactoryBot.define do
  factory :post do
    title { Faker::Lorem.words(number: rand(5) + 4).join(" ").capitalize }
    body { Faker::Lorem.sentences(number: rand(3) + 3).join(" ") }
    user { FactoryBot.create(:user) }
    
    
    # posted_at { DateTime.now }
  end
end
