class UserReview < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :challenge

  after_create :set_receiver_score

  validate :difference_of_players
  validates :thumb, :content, presence: true
  validates :serve, :return, :backhand, :forehand, :volley, :speed, :power, :endurance,
            presence: true

  private

  def difference_of_players
    errors.add(:sender_id, 'You can not review yourself') if sender_id == receiver_id
  end

  def set_receiver_score
    total_size = receiver.received_reviews.length
    thumbs_up = receiver.received_reviews.count { |review| review.thumb? }
    receiver.review_score = total_size / thumbs_up
  end
end
