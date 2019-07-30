class Match < ApplicationRecord
  belongs_to :player, class_name: 'User'
  belongs_to :opponent, class_name: 'User'
  has_many :user_reviews, dependent: :destroy
end
