class CreateFaces < ActiveRecord::Migration[5.0]
  def change
    create_table :faces do |t|
      t.integer :capture_id
      t.integer :character_id
      t.integer :emotion_id
      t.integer :x
      t.integer :y
      t.integer :w
      t.integer :h
      t.boolean :is_face, default: true

      t.timestamps
    end
  end
end
