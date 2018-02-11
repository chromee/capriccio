class AddAttachmentPictureToFace < ActiveRecord::Migration[5.0]
  def self.up
    change_table :faces do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :faces, :picture
  end
end
