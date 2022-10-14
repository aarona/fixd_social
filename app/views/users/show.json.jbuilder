json.posts do
  json.array! @activities do |activity|
    json.id activity.id
    json.type activity.loggable_type
    json.user_id activity.user_id
    # json.partial! 'activities/loggable', loggable: activity.loggable, type: activity.loggable_type, as: :post
    case activity.loggable_type
    when "CommentNotification"
      json.partial! 'comment_notifications/comment_notification', post: activity.loggable, as: :post
    when "CreateEvent"
      json.partial! 'create_events/create_event', post: activity.loggable, as: :post
    when "Post"
      json.partial! 'posts/post', post: activity.loggable, as: :post
    when "PullRequestEvent"
      json.partial! 'pull_request_events/pull_request_event', post: activity.loggable, as: :post
    when "PushEvent"
      json.partial! 'push_events/push_event', post: activity.loggable, as: :post
    when "RatingChange"
      json.partial! 'rating_changes/rating_change', post: activity.loggable, as: :post
    end
    json.posted_at activity.posted_at
  end
end
