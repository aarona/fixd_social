class CreateEvent < ApplicationRecord
  include Loggable
  include GithubEvents

  validates_presence_of :repo

  after_create :create_github_activity!
end
