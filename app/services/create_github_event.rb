class CreateGithubEvent
  attr_reader :event
  attr_reader :skipped
  attr_reader :error_messages

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
        puts "  Created a new Repo"
        
      # Pushed some commmits
      when "PushEvent"
        puts "  Pushed some commits"

      when "PullRequestEvent"
        # Opened a new Pull Request
        if @event["payload"]["action"] == "opened" ||
           @event["payload"]["action"] == "closed"

           service = CreatePullRequestEvent.new({
            user_id: @user.id,
            number: @event["payload"]["number"],
            repo: @event["repo"]["name"],
            action: @event["payload"]["action"],
            created_at: @event["created_at"],
          })

          return true if service.save

          @error_messages = service.error_messages
          return false
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
end