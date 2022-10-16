class CreateCreateEvent < CreateRecord
  # Valid Parameters are:
  #   :event_id - The unique id for this event on Github
  #   :user_id - The id of the user this event belongs to
  #   :repo - The name of the repository the pull request is on
  #   :created_at - The time when the event was created
  #     (This will become the posted_at attribute for the assocaited Activity)
  def initialize(params)
    super(CreateEvent, params)
  end
end