require 'faraday'

# Running out of time so I'm going to go into detail about how I would solve
# this problem. Was planning on iterating over the array of objects that were
# returned. The pertinent information were in the "payload": {...} portions of
# each object. Based on each object's "type": "..." value (PullRequest,
# PullRequestEvent etc) I would build a post around each payload using the
# "message" attribute or a "title" attribute. That could be done inside a
# seperate service object. Maybe something called ProcessEvent which would take
# in one entry hash at a time and then return a proper body and title.
#
# Idealy, a background process would do this periodically and skip duplicate
# entires that have already been posted. Possibly only reading events until it
# found the id of the last one it encountered. The best way would be able to
# somehow filter the API results when making the request with a date/time that
# would be to stored that was the last time the request was made and filter out
# events that occurred before that time.
class RequestGithubEvents
  GITHUB_API_URL = "https://api.github.com"

  attr_reader :events
  attr_reader :imported, :skipped, :errors

  def initialize(user)
    @user = user
    github_username = user.github_username
    @api_url = "#{GITHUB_API_URL}/users/#{github_username}/events"
    @events = []
    @imported = @skipped = @errors = 0
  end

  def import
    puts "  GET #{@api_url}"
    request_events
    process_events
  end
  
  private

  def request_events
    @response = Faraday.get(@api_url)
  end
  
  def process_events
    events = JSON.parse(@response.body)

    puts "  Events found: #{events.length}"
    events.each do |event|
      event = CreateGithubEvent.new(@user, event)

      if event.save
        @events << event
        @imported += 1
      elsif event.skipped?
        @skipped += 1
      else
        @errors += 1
      end
    end
  end
end