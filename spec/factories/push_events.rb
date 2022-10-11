FactoryBot.define do
  factory :push_event do
    event_id { 1 }
    user { create(:user) }
    commits { 1 }
    repo { "fixd_social" }
    branch { "refs/heads/master" }
    created_at { DateTime.now }
  end
end
