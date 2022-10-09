# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating Users..."
users = []
10.times do
  user = FactoryBot.create(:user)
  users << user
end

puts "Creating Posts..."
posts = []
users.each do |user|
  (rand(10) + 5).times do
    cp = CreatePost.new({
      user_id: user.id,
      title: Faker::Lorem.words(number: rand(5) + 4).join(" ").capitalize,
      body: Faker::Lorem.sentences(number: rand(3) + 3).join(" ")
    })
    cp.save
    posts << cp.post
  end
end

puts "Creating Comments..."
users.each do |user|
  20.times do
    post = posts[rand(posts.length)]
    value = CreateComment.new({
      user_id: user.id,
      post_id: post.id,
      message: Faker::Lorem.sentence(word_count: rand(5) + 10)
    }).save
  end
end

puts "Creating Ratings..."
users.each do |user|
  7.times do
    user_to_be_rated = users[rand(users.length)]
    next if user.id == user_to_be_rated.id

    value = CreateRating.new({
      user_id: user_to_be_rated.id,
      rater_id: user.id,
      rating: rand(5) + 1
    }).save
  end
end