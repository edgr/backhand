class UserReview < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :challenge

  validate :difference_of_players
  validates :thumb, inclusion: { in: [true, false] }
  validates :content, presence: true
  validates :serve, :return, :backhand, :forehand, :volley, :speed, :power, :endurance,
            presence: true

  before_create :set_challenge, :set_receiver
  after_create :set_receiver_score, :skills_set_update

  private

  def difference_of_players
    errors.add(:sender_id, 'You can not review yourself') if sender_id == receiver_id
  end

  def set_challenge
    @challenge = Challenge.find(challenge_id)
  end

  def set_receiver
    @receiver = @challenge.other_user(@current_user)
  end

  def set_receiver_score
    total_size = @receiver.received_reviews.length
    thumbs_up = @receiver.received_reviews.count { |review| review.thumb? }
    @receiver.review_score = (thumbs_up / total_size.to_f) * 100
    @receiver.save
  end

  def final_score(oldavgscore, newskillscore, length)
    final_score = (oldavgscore * (length - 1) + newskillscore) / length
  end

  def skills_set_update
    @receiver_skills = ComputedSkillsSet.where(user_id: @receiver.id)[0]
    length = @receiver_skills.user.received_reviews.length
    # user_review = params[:user_review]

    avg_serve_score = @receiver_skills.serve
    new_serve_score = serve.to_f
    @receiver_skills.serve = final_score(avg_serve_score, new_serve_score, length)

    # avg_return_score = @receiver_skills.return
    # new_return_score = return.to_f
    # @receiver_skills.return = final_score(avg_return_score, new_return_score, length)

    avg_forehand_score = @receiver_skills.forehand
    new_forehand_score = forehand.to_f
    @receiver_skills.forehand = final_score(avg_forehand_score, new_forehand_score, length)

    avg_backhand_score = @receiver_skills.backhand
    new_backhand_score = backhand.to_f
    @receiver_skills.backhand = final_score(avg_backhand_score, new_backhand_score, length)

    avg_volley_score = @receiver_skills.volley
    new_volley_score = volley.to_f
    @receiver_skills.volley = final_score(avg_volley_score, new_volley_score, length)

    avg_speed_score = @receiver_skills.speed
    new_speed_score = speed.to_f
    @receiver_skills.speed = final_score(avg_speed_score, new_speed_score, length)

    avg_power_score = @receiver_skills.power
    new_power_score = power.to_f
    @receiver_skills.power = final_score(avg_power_score, new_power_score, length)

    avg_endurance_score = @receiver_skills.endurance
    new_endurance_score = endurance.to_f
    @receiver_skills.endurance = final_score(avg_endurance_score, new_endurance_score, length)

    @receiver_skills.save
  end
end
