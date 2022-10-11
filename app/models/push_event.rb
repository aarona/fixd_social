class PushEvent < ApplicationRecord
  include Loggable

  belongs_to :user
  has_one :activity, as: :loggable, dependent: :destroy

  validates_presence_of :event_id, :commits, :repo, :branch, :created_at
  validates_uniqueness_of :event_id, message: "must be unique"

  after_create :create_github_activity!
  after_save :save_activity!
end
