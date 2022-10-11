class Post < ApplicationRecord
  include Loggable

  belongs_to :user
  has_one :activity, as: :loggable, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope { includes(:activity) }

  scope :feed, -> (user_id:, limit:, offset:) {
    # TODO: Could set max value for limit here.
    # Something like 20 for example.
    includes(:comments, :activity)
      .where(user_id: user_id)
      .limit(Integer(limit ||= 5))
      .offset(Integer(offset ||= 0))
  }

  validates_presence_of :title, :body

  after_create :create_activity!
  after_save :save_activity!

  def comment_count
    comments.length
  end
end
