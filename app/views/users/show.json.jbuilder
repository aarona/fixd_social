json.posts do
  json.array! @posts, :id, :user_id, :title, :body, :posted_at, :comment_count
end