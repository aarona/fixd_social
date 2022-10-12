class RatingChange < ApplicationRecord
  include Loggable

  default_scope { includes(:activity) }

  validates_presence_of :rating

  after_create :create_activity!
end
