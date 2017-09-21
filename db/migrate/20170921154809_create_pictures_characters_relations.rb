class CreatePicturesCharactersRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures_characters_relations do |t|
      t.integer :picture_id
      t.integer :character_id

      t.timestamps
    end
  end
end
