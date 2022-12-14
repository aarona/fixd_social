# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_12_021720) do
  create_table "activities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "loggable_id", null: false
    t.string "loggable_type", null: false
    t.datetime "posted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loggable_id", "loggable_type"], name: "index_activities_on_loggable_id_and_loggable_type", unique: true
    t.index ["posted_at"], name: "index_activities_on_posted_at"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "comment_notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "poster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comment_notifications_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.string "message", null: false
    t.datetime "commented_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commented_at"], name: "index_comments_on_commented_at"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "create_events", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.string "repo", null: false
    t.datetime "created_at", null: false
    t.index ["event_id"], name: "index_create_events_on_event_id", unique: true
    t.index ["user_id"], name: "index_create_events_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "body", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "pull_request_events", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.integer "number", null: false
    t.string "repo", null: false
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.index ["event_id"], name: "index_pull_request_events_on_event_id", unique: true
    t.index ["user_id"], name: "index_pull_request_events_on_user_id"
  end

  create_table "push_events", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.integer "commits", null: false
    t.string "repo", null: false
    t.string "branch", null: false
    t.datetime "created_at", null: false
    t.index ["event_id"], name: "index_push_events_on_event_id", unique: true
    t.index ["user_id"], name: "index_push_events_on_user_id"
  end

  create_table "rating_changes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rating_changes_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "rater_id", null: false
    t.integer "rating", null: false
    t.datetime "rated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rater_id", "user_id"], name: "index_ratings_on_rater_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "github_username"
    t.datetime "registered_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "comment_notifications", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "create_events", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "pull_request_events", "users"
  add_foreign_key "push_events", "users"
  add_foreign_key "rating_changes", "users"
  add_foreign_key "ratings", "users"
  add_foreign_key "ratings", "users", column: "rater_id"
end
