class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.integer :year
      t.integer :season_id
      t.integer :studio_id

      t.timestamps
    end
  end
end
