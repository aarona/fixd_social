FactoryBot.define do
  factory :rating do
    user { FactoryBot.create(:user) }
    rater { FactoryBot.create(:user) }
    rating { Faker::Number.between from: 1, to: 5 }
    rated_at { DateTime.now }
  end
end
