# == Schema Information
#
# Table name: faces
#
#  id                   :integer          not null, primary key
#  capture_id           :integer
#  character_id         :integer
#  emotion_id           :integer
#  x                    :integer
#  y                    :integer
#  w                    :integer
#  h                    :integer
#  is_face              :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Face < ApplicationRecord
  
  has_attached_file :picture,
    url: "/pictures/faces/:id/:basename.:extension",
    path: "#{Rails.root}/public/pictures/faces/:id_:basename.:extension"
  validates_attachment :picture,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
