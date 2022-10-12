json.(post, :user_id)
json.set! :rating_threshold, post.rating
json.(post.user, :average_rating)