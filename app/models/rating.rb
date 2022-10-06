class Rating < ApplicationRecord
  belongs_to :rater, class_name: "User", foreign_key: "rater_id"
  belongs_to :user
  validates_presence_of :rating, :rated_at
  validates_numericality_of :rating, less_than_or_equal_to: 5, greater_than_or_equal_to: 1

  # A nice TODO:
  # a before_create block setting the rated_at date
  # to the current time might be a nice feature here.

  # A nice TODO:
  # Adding a compound unique index for user/rater migration
  # and an accompanying validator that prevents a user from
  # rating another more than once would also be nice here.
  # validates_with RatersMustBeUnique

  # A nice TODO:
  # Preventing a User from rating themselves.
end
