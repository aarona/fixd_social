class CreatePushEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :push_events do |t|
      t.integer :event_id, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :commits, null: false
      t.string :repo, null: false
      t.string :branch, null: false
      t.datetime :created_at, null: false
      t.index :event_id, unique: true
    end
  end
end
