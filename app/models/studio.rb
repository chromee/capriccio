class Studio < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  def animes
    Anime.where(studio_id: self.id).to_a
  end
end
