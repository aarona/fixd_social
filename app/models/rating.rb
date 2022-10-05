class Rating < ApplicationRecord
  belongs_to :rater, class_name: "User", foreign_key: "rater_id"
  belongs_to :user
  validates_presence_of :rating
end
