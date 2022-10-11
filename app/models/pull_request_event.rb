class PullRequestEvent < ApplicationRecord
  include Loggable
  include GithubEvents

  validates_presence_of :number, :repo, :action

  after_create :create_github_activity!
end
