class Capture < ApplicationRecord
  require 'opencv'
  include OpenCV

  attr_accessor :content_type, :original_filename, :image_data

  # 画像の設定
  has_attached_file :picture,
    styles: { large:"1000x1000", small: "300x300" } ,
    url: "/pictures/:id/:style/:basename.:extension",
    path: "#{Rails.root}/public/pictures/:id/:style/:basename.:extension"
  validates_attachment :picture,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # タグの設定
  acts_as_taggable_on :tags

  def character_ids
    CapturesCharactersRelation.where(capture_id: self.id).pluck(:character_id)
  end

  def anime
    Anime.find_by_id(self.anime_id)
  end

  def gray_img
    # face_detector = OpenCV::CvHaarClassifierCascade::load "#{Rails.root.to_s}/cascader/lbpcascade_animeface.xml"
    path = "#{Rails.root.to_s}/public/assets/arts/#{self.id}"
    img = CvMat.load("#{path}/original/#{self.picture_file_name}")
    gray_img = img.BGR2GRAY
    gray_img.save_image("#{path}/gray/#{self.picture_file_name}")
    return "#{path}/gray/#{self.picture_file_name}"
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

end
