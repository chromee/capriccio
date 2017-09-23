class Studio < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
