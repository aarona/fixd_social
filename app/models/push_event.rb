class PushEvent < ApplicationRecord
  include Loggable
  include GithubEvents

  validates_presence_of :commits, :repo, :branch

  after_create :create_github_activity!
end
