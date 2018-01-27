class Picture < ApplicationRecord
  attr_accessor :content_type, :original_filename, :image_data
  before_save :decode_base64_image

  belongs_to :anime, foreign_key: "anime_id"

  # 画像の設定
  paperclip_opts = {
    styles: { large:"1000x1000", medium: "300x300>" } ,
    url: "/assets/arts/:id/:style/:basename.:extension",
    path: "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension"}
  has_attached_file :photo, paperclip_opts
  validates_attachment :photo,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # タグの設定
  acts_as_taggable_on :emotions, :tags

  def character_ids
    PicturesCharactersRelation.where(picture_id: self.id).pluck(:character_id)
  end

  def anime
    Anime.find_by_id(self.anime_id)
  end

  protected
    def decode_base64_image
      if image_data && content_type && original_filename
        decoded_data = Base64.decode64(image_data)

        data = StringIO.new(decoded_data)
        data.class_eval do
          attr_accessor :content_type, :original_filename
        end

        data.content_type = content_type
        data.original_filename = File.basename(original_filename)

        self.image = data
      end
    end
end
