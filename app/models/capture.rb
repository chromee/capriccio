# == Schema Information
#
# Table name: captures
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  anime_id             :integer
#  emotion_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Capture < ApplicationRecord
  require 'opencv'
  require "google/cloud/vision"
  include OpenCV

  # 画像の設定
  has_attached_file :picture,
    styles: { large:"1000x1000", small: "300x300" } ,
    url: "/pictures/captures/:id/:style/:basename.:extension",
    path: "#{Rails.root}/public/pictures/captures/:id/:style/:basename.:extension"
  validates_attachment :picture,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # タグの設定
  acts_as_taggable_on :tags

  def character_ids
    Face.where(capture_id: self.id).pluck(:character_id)
  end

  def anime
    Anime.find_by_id(self.anime_id)
  end

  def trimming_face!(attr)
    begin
      img = CvMat.load self.picture.path
      face_pic = img.sub_rect attr[:x], attr[:y], attr[:w], attr[:h]
      face = Face.new(
        capture_id: self.id,
        emotion_id: attr[:emotion_id],
        character_id: attr[:character_id],
        x: attr[:x], y: attr[:y], w: attr[:w], h: attr[:h]
      )
      tmp_path = "#{Rails.root}/tmp/#{self.picture.original_filename}"
      face_pic.save_image tmp_path
      File.open(tmp_path) do |pic|
        face.picture = pic
        face.save!
      end
      File.delete tmp_path
      return true
    rescue => e
      return false, e
    end
  end

  def self.create_from_file(img_path)
    pic = Capture.new
    file = File.open(img_path)
    pic.picture = file
    file.close
    pic.save!

    # 保存サンプル
    # Capture.create_from_file("#{Rails.root.to_s}/public/tmp/ren.jpg")
  end

  def generate_message
    vision = Google::Cloud::Vision.new project: ENV.fetch('GOOGLE_PROJECT_ID')
    image  = vision.image self.picture.path
    return image.text
  end

end
