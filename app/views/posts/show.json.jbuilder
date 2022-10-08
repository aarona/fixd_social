json.post do
  json.partial! 'posts/post', post: @post

  json.comments @post.comments do |comment|
    json.comment do
      json.partial! 'comments/comment', comment: comment
    end
    json.user do
      json.partial! 'users/user', user: comment.user
    end
  end
end