class CommentNotification < ApplicationRecord
  include Loggable

  belongs_to :poster, class_name: "User"

  default_scope { includes(:activity) }

  after_create :create_activity!
end
