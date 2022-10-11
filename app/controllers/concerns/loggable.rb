module Loggable
  extend ActiveSupport::Concern

  def posted_at
    return nil unless activity.present?

    activity.posted_at
  end

  def posted_at=(value)
    activity.post_at = value
  end

  def create_activity!
    Activity.create(user_id: self.user_id, loggable: self, posted_at: DateTime.now)
  end
  
  def save_activity!
    return unless activity.changed?

    Activity.save
  end
end