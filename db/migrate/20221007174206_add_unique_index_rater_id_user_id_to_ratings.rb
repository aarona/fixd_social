class AddUniqueIndexRaterIdUserIdToRatings < ActiveRecord::Migration[7.0]
  def change
    add_index :ratings, [:rater_id, :user_id], unique: true
  end
end
