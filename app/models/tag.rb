class Tag < ApplicationRecord
  has_many :users, through: :user_tags
end
