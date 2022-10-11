class CreatePushEvent
  attr_reader :event
  attr_reader :error_messages

  # Valid Parameters are:
  #   :event_id - The unique id for this event on Github
  #   :user_id - The id of the user this event belongs to
  #   :commits - The number of commits in this push
  #   :repo - The name of the repository the pull request is on
  #   :branch - Valid options are "opened" and "closed"
  #   :created_at - The time when the event was created
  #     (This will become the posted_at attribute for the assocaited Activity)
  def initialize(params)
    @error_messages = []
    @params = params
  end
  
  def save
    @event = PushEvent.new(@params)

    return true if @event.save

    @error_messages = @event.errors.full_messages
    false
  end
end