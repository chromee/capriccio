class CreateCaptures < ActiveRecord::Migration[5.0]
  def change
    create_table :captures do |t|
      t.string :name
      t.integer :anime_id
      t.integer :emotion_id

      t.timestamps
    end
  end
end
