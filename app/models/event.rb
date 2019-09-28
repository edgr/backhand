class Event < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, -> { where('status = ?', 'active') }, class_name: 'User'
  belongs_to :player_3, -> { where('status = ?', 'active') }, class_name: 'User', optional: true
  belongs_to :player_4, -> { where('status = ?', 'active') }, class_name: 'User', optional: true
  belongs_to :club

  validates :player_1, :player_2, presence: :true
  validate :difference_of_players

  private

  def difference_of_players
    errors.add(:player_1_id, 'Players cannot be the same') if player_1_id == player_2_id
  end
end
