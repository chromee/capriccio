class Anime < ApplicationRecord
  validates :title, uniqueness: true, presence: true
end
