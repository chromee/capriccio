class AddEmotionCColumnPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :emotion_id, :integer
  end
end
