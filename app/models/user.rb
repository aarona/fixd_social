class User < ApplicationRecord
  validates_presence_of :email, :name, :registered_at
  validates_uniqueness_of :email
end
