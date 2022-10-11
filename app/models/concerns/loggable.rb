module Loggable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :loggable, dependent: :destroy
    belongs_to :user

    after_save :save_activity!
  end

  def posted_at
    return nil unless activity.present?

    activity.posted_at
  end

  def posted_at=(value)
    activity.post_at = value if activity.present?
  end

  def create_activity!
    Activity.create(user_id: self.user_id, loggable: self, posted_at: DateTime.now)
  end

  def save_activity!
    return unless activity.changed?

    Activity.save
  end
end