class CreateCapturesCharactersRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :captures_characters_relations do |t|
      t.integer :capture_id
      t.integer :character_id

      t.timestamps
    end
  end
end
