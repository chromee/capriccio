class AddAttachmentPictureToCaptures < ActiveRecord::Migration[4.2]
  def self.up
    change_table :captures do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :captures, :picture
  end
end
