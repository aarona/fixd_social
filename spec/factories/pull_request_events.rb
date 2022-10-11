FactoryBot.define do
  factory :pull_request_event do
    event_id { 1 }
    user { create(:user) }
    number { 1 }
    repo { "fixd_social" }
    action { "open" }
    created_at { DateTime.now }
  end
end
