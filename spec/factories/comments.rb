FactoryBot.define do
  factory :comment do
    user { FactoryBot.create(:user) }
    post { FactoryBot.create(:post) }
    message { Faker::Lorem.sentence(word_count: rand(5) + 10) }
    commented_at { DateTime.now }
  end
end
