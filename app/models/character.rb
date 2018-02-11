class Character < ApplicationRecord
  validates :name, presence: true

  def anime
    Anime.find_by_id(self.anime_id).to_a
  end

  def capture_ids
    CapturesCharactersRelation.where(character_id: self.id).pluck(:capture_id)
  end
end
