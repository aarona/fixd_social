class CreateRatingChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :rating_changes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
