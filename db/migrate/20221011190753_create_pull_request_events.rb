class CreatePullRequestEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :pull_request_events do |t|
      t.integer :event_id, null: false, unique: true, index: true
      t.references :user, null: false, foreign_key: true
      t.integer :number, null: false
      t.string :repo, null: false
      t.string :action, null: false
      t.datetime :created_at, null: false
    end
  end
end
