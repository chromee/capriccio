# == Schema Information
#
# Table name: user_favorite_captures
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  capture_id :integer
#  favorite   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserFavoriteCapture < ApplicationRecord
end
