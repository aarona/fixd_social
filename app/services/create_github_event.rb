class CreateGithubEvent < CreateRecord
  attr_reader :event
  attr_reader :skipped

  # This should be a hash object from an events collection
  # from the GitHub public API
  def initialize(user, event)
    @skipped = false
    @user = user
    @event = event
  end

  def save
    event_type = @event["type"]
    case event_type
      # Created a new Repo
      when "CreateEvent"
        return create_create_event!

      # Pushed some commmits
      when "PushEvent"
        return create_push_event!

      when "PullRequestEvent"
        # Opened a new Pull Request
        if @event["payload"]["action"] == "opened" ||
           # Merge a Pull Request
           @event["payload"]["action"] == "closed"

           return create_pull_request_event!
        else
          @skipped = true
          return false
        end
      else
        @skipped = true
        return false
      end
  end

  def skipped?
    @skipped
  end

  private

  def create_create_event!
    service = CreateCreateEvent.new({
      event_id: @event["id"],
      user_id: @user.id,
      repo: @event["repo"]["name"],
      created_at: @event["created_at"]
    })

    return true if service.save

    @skipped = true
    set_error_messages!
  end
  
  def create_pull_request_event!
    service = CreatePullRequestEvent.new({
      event_id: @event["id"],
      user_id: @user.id,
      number: @event["payload"]["number"],
      repo: @event["repo"]["name"],
      action: @event["payload"]["action"],
      created_at: @event["created_at"]
    })

    return true if service.save

    @skipped = true
    set_error_messages!
  end

  def create_push_event!
    service = CreatePushEvent.new({
      event_id: @event["id"],
      user_id: @user.id,
      commits: @event["payload"]["commits"].length,
      repo: @event["repo"]["name"],
      branch: @event["payload"]["ref"],
      created_at: @event["created_at"]
    })

    return true if service.save

    @skipped = true
    set_error_messages!
  end
end
