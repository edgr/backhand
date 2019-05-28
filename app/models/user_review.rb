class UserReview < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :challenge

  validate :difference_of_players
  validates :thumb, :content, presence: true

  private

  def difference_of_players
    errors.add(:sender_id, 'You can not review yourself') if sender_id == receiver_id
  end
end
