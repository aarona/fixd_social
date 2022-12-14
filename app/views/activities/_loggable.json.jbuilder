case type
when "CommentNotification"
  json.partial! 'comment_notifications/comment_notification', post: loggable, as: :post
when "CreateEvent"
  json.partial! 'create_events/create_event', post: loggable, as: :post
when "Post"
  json.partial! 'posts/post', post: loggable, as: :post
when "PullRequestEvent"
  json.partial! 'pull_request_events/pull_request_event', post: loggable, as: :post
when "PushEvent"
  json.partial! 'push_events/push_event', post: loggable, as: :post
when "RatingChange"
  json.partial! 'rating_changes/rating_change', post: loggable, as: :post
end