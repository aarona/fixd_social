class CreateCreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :create_events do |t|
      t.integer :event_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string :repo, null: false
      t.datetime :created_at, null: false
      t.index :event_id, unique: true
    end
  end
end
