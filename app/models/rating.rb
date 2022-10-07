class Rating < ApplicationRecord
  belongs_to :rater, class_name: "User", foreign_key: "rater_id"
  belongs_to :user
  validates_presence_of :rating, :rated_at
  validates_numericality_of :rating, less_than_or_equal_to: 5, greater_than_or_equal_to: 1
end
