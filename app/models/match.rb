class Match < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  has_many :user_reviews, dependent: :destroy
  has_many :match_sets, dependent: :destroy
  has_one :match_result, dependent: :destroy

  validates :player_1, :player_2, presence: :true # :date,
end
