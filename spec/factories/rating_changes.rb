FactoryBot.define do
  factory :rating_change do
    user { create(:user) }
    rating { 5 }
  end
end
