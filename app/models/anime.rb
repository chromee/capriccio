class Anime < ApplicationRecord
  validates :title, uniqueness: true
end
