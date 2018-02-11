class Capture < ApplicationRecord
  require 'opencv'
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

  def trimming_face(x, y, w, h, character_id=nil)
    img = CvMat.load self.picture.path
    face_pic = img.sub_rect x, y, w, h
    face = Face.new(
      capture_id: self.id,
      character_id: character_id,
      x: x, y: y, w: w, h: h,
      is_face: true
    )
    tmp_path = "#{Rails.root}/tmp/#{self.picture.original_filename}"
    face_pic.save_image tmp_path
    File.open(tmp_path) do |pic|
      face.picture = pic
      face.save!
    end
    File.delete tmp_path
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
