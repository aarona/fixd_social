FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    github_username { nil }
    registered_at { DateTime.now }
  end
end
