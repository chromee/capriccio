class AddPostUserIdToCptures < ActiveRecord::Migration[5.1]
  def change
    add_column :captures, :posted_user_id, :integer
  end
end
