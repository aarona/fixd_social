class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :loggable, polymorphic: true, dependent: :destroy

  default_scope { order("posted_at desc") }

  scope :feed, -> (user_id:, limit:, offset:) {
    # TODO: Could set max value for limit here.
    # Something like 20 for example.
    includes(:loggable, :user)
      .where(user_id: user_id)
      .limit(Integer(limit ||= 5))
      .offset(Integer(offset ||= 0))
  }

  validates_presence_of :posted_at
end
