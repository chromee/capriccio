class Character < ApplicationRecord
  validates :title, presence: true

  def anime
    Anime.find_by_id(self.anime_id).to_a
  end

  def picture_ids
    PicturesCharactersRelation.where(character_id: self.id).pluck(:picture_id)
  end
end
