class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :loggable_id, null: false
      t.string :loggable_type, null: false
      t.datetime :posted_at, null: false, index: true

      t.timestamps
    end

    add_index :activities, [:loggable_id, :loggable_type], unique: true
  end
end
