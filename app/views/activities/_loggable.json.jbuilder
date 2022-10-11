case type
when "CreateEvent"
  json.partial! 'create_events/create_event', post: loggable, as: :post
when "Post"
  json.partial! 'posts/post', post: loggable, as: :post
when "PullRequestEvent"
  json.partial! 'pull_request_events/pull_request_event', post: loggable, as: :post
when "PushEvent"
  json.partial! 'push_events/push_event', post: loggable, as: :post
end