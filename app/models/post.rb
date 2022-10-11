class Post < ApplicationRecord
  include Loggable

  has_many :comments, dependent: :destroy

  default_scope { includes(:activity) }

  validates_presence_of :title, :body

  after_create :create_activity!

  def comment_count
    comments.length
  end
end
