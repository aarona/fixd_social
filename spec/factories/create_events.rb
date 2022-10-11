FactoryBot.define do
  factory :create_event do
    event_id { 1 }
    user { create(:user) }
    repo { "fixd_social" }
    created_at { DateTime.now }
  end
end
