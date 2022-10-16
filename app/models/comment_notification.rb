class CommentNotification < ApplicationRecord
  include Loggable

  belongs_to :poster, class_name: "User"

  default_scope { includes(:activity, :poster) }

  after_create :create_activity!
end
