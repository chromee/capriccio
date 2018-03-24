# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  anime_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Character < ApplicationRecord
  validates :name, presence: true

  def anime
    Anime.find_by_id(self.anime_id).to_a
  end

  def capture_ids
    Face.where(character_id: self.id).pluck(:capture_id)
  end
end
