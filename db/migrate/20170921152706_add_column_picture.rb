class AddColumnPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :anime_id, :integer
  end
end
