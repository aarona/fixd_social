class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :loggable, polymorphic: true, dependent: :destroy

  default_scope { order("posted_at desc") }


  validates_presence_of :posted_at
end
