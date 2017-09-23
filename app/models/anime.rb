class Anime < ApplicationRecord
  validates :title, uniqueness: true, presence: true

  def characters
    Character.where(anime_id: self.id).to_a
  end

  def studio
    Studio.find_by_id(self.studio_id)
  end
end
