class CreateCommentNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :poster_id, null: false

      t.timestamps
    end
  end
end
