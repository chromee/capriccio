# == Schema Information
#
# Table name: captures
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  comment              :text(65535)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Capture < ApplicationRecord
  require "google/cloud/vision"

  paperclip_options = {
    styles: { large:"1000x1000" } ,
    url: "/pictures/captures/:id/:style/:basename.:extension",
    path: "#{Rails.root}/public/pictures/captures/:id/:style/:basename.:extension",
  }

  if Rails.env.production?
    paperclip_options.merge!(
      storage: :fog,
      fog_directory: ENV.fetch("GCS_BUCKET_NAME"),
      fog_credentials: {
        provider: "Google",
        google_storage_access_key_id: ENV.fetch("GCS_ACCESS_KEY"),
        google_storage_secret_access_key: ENV.fetch("GCS_SECRET_KEY"),
      }
    )
  end

  has_attached_file :picture, paperclip_options

  validates_attachment :picture,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # タグの設定
  acts_as_taggable_on :tags

  def generate_message!
    vision = Google::Cloud::Vision.new project: ENV.fetch("GOOGLE_PROJECT_ID")
    image = vision.image self.picture.path
    self.update_attribute(:comment, image.text)
  end

end
