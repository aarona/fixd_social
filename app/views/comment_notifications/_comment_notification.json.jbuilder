json.(post, :user_id)
json.poster do
  poster = post.poster
  json.id poster.id
  json.name poster.name
  json.average_rating poster.average_rating
end