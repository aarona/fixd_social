class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :feed, -> (user_id:, limit:, offset:) {
    # TODO: Could set max value for limit here.
    # Something like 20 for example.
    includes(:comments)
      .where(user_id: user_id)
      .limit(Integer(limit ||= 5))
      .offset(Integer(offset ||= 0))
  }

  validates_presence_of :title, :body, :posted_at

  def comment_count
    comments.length
  end
end
