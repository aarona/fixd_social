# Pull Request Events can be either New or Merged depending on the action.
class CreatePullRequestEvent < CreateRecord
  # Valid Parameters are:
  #   :event_id - The unique id for this event on Github
  #   :user_id - The id of the user this event belongs to
  #   :number - The number of the pull request
  #   :repo - The name of the repository the pull request is on
  #   :action - Valid options are "opened" and "closed"
  #   :created_at - The time when the event was created
  #     (This will become the posted_at attribute for the assocaited Activity)
  def initialize(params)
    super(PullRequestEvent, params)
  end
end