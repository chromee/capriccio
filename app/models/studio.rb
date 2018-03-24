# == Schema Information
#
# Table name: studios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Studio < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  def animes
    Anime.where(studio_id: self.id).to_a
  end
end
