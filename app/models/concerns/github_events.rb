module GithubEvents
  extend ActiveSupport::Concern

  included do
    validates_presence_of :event_id, :created_at
    validates_uniqueness_of :event_id, message: "must be unique"
  end

  # def posted_at
  #   return nil unless activity.present?

  #   activity.posted_at
  # end

  def posted_at=(value)
    created_at = value
    activity.post_at = value if activity.present?
  end

  def create_github_activity!
    Activity.create(user_id: self.user_id, loggable: self, posted_at: self.created_at)
  end
end