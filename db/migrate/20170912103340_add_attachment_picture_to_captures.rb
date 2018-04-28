class AddAttachmentPictureToCaptures < ActiveRecord::Migration[5.0]
  def self.up
    change_table :captures do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :captures, :picture
  end
end
