class CreateUserFavoriteCaptures < ActiveRecord::Migration[5.1]
  def change
    create_table :user_favorite_captures do |t|
      t.integer :user_id
      t.integer :capture_id
      t.boolean :favorite

      t.timestamps
    end
  end
end
