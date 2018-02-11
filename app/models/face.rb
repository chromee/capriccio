class Face < ApplicationRecord
  
  has_attached_file :picture,
    url: "/pictures/faces/:id/:basename.:extension",
    path: "#{Rails.root}/public/pictures/faces/:id_:basename.:extension"
  validates_attachment :picture,
    less_than: 20.megabytes,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
