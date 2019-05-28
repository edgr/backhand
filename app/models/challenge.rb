class Challenge < ApplicationRecord
  belongs_to :challenger, class_name: 'User'
  belongs_to :challengee, class_name: 'User'

  validate :difference_of_players
  validates :status, presence: true, default: 'Pending'
  validates :challenger, :challengee, presence: true

  private

  def difference_of_players
    errors.add(:challenger_id, 'Challenger and Challengee must be different') if challenger_id == challengee_id
  end
end
