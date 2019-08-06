class Match < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :club
  has_many :match_sets, dependent: :destroy
  has_one :match_result, dependent: :destroy

  validates :player_1, :player_2, presence: :true # :date,
  validate :difference_of_players
  accepts_nested_attributes_for :match_result, :match_sets, allow_destroy: true

  private

  def difference_of_players
    errors.add(:player_1_id, 'Players cannot be the same') if player_1_id == player_2_id
  end
end
