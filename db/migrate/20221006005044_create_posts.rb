class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :posted_at

      t.timestamps
    end
  end
end