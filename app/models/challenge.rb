class Challenge < ApplicationRecord
  belongs_to :challenger, class_name: 'User'
  belongs_to :challengee, class_name: 'User'
  has_many :user_reviews, dependent: :destroy

  validate :difference_of_players
  validates :status, presence: true
  validates :challenger, :challengee, presence: true

  # statuses = %w(played accepted pending declined challenger_reviewed)

  scope :played, -> { where(status: 'played') }

  def other_user(current_user)
    [challenger, challengee].find { |user| user != current_user }
  end

  # statuses.each do |status|
  #   define_method "#{status}?" do
  #     self.status == status
  #   end
  # end

  private

  def difference_of_players
    errors.add(:challenger_id, 'Challenger and Challengee must be different') if challenger_id == challengee_id
  end
end
