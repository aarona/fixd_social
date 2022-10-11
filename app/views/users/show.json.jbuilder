json.posts do
  json.array! @activities do |activity|
    json.id activity.id
    json.type activity.loggable_type
    json.user_id activity.user_id
    json.partial! 'activities/loggable', loggable: activity.loggable, type: activity.loggable_type, as: :post
    json.posted_at activity.posted_at
  end
end
