class User < ApplicationRecord
  has_many :ratings
  has_many :posts
  has_many :activities, dependent: :destroy
  
  default_scope { includes(:ratings) }

  validates_presence_of :email, :name, :registered_at
  validates_uniqueness_of :email

  def average_rating
    rating_values = ratings.pluck(:rating)

    return 0 if rating_values.empty?

    rating_values.sum / rating_values.length
  end
end
