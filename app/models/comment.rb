class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # default_scope { order(:commented_at) }

  validates_presence_of :message, :commented_at
end
