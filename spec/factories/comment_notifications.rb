FactoryBot.define do
  factory :comment_notification do
    user { create(:user) }
    poster {
      poster = create(:user)
      create(:post, user: poster)
      poster
    }
  end
end
