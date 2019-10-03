class Event < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, -> { where('status = ?', 'active') }, class_name: 'User'
  belongs_to :player_3, -> { where('status = ?', 'active') }, class_name: 'User', optional: true
  belongs_to :player_4, -> { where('status = ?', 'active') }, class_name: 'User', optional: true
  belongs_to :club, optional: true

  validates :player_1, :player_2, presence: :true
  # validates :difference_of_players
  validates :date_time, presence: true
  scope :upcoming, -> { where("date_time >= ?", Date.today) }

  private

  def difference_of_players
    errors.add(:player_1_id, 'Players cannot be the same') if player_1_id == player_2_id
  end
end
