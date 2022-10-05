class User < ApplicationRecord
  has_many :ratings
  validates_presence_of :email, :name, :registered_at
  validates_uniqueness_of :email
end
