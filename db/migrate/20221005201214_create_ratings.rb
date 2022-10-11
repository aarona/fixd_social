class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rater_id, null: false
      t.integer :rating, null: false
      t.datetime :rated_at, null: false
      t.timestamps
    end
    
    add_foreign_key :ratings, :users, column: :rater_id
    add_index :ratings, [:rater_id, :user_id], unique: true
  end
end
