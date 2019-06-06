class UserReviewsController < ApplicationController
  before_action :set_challenge, only: %i[new create]
  before_action :set_receiver, only: [:create]

  def new
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(review_params)
    @user_review.challenge = @challenge
    @sender = current_user
    @user_review.sender_id = @sender.id
    @user_review.receiver_id = @receiver.id
    if @user_review.save
      set_receiver_score
      skills_set_update
      redirect_to user_path(@receiver)
    else
      render :new
    end
  end

  def destroy
    UserReview.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end

  private

  def set_receiver_score
    total_size = @receiver.received_reviews.length
    thumbs_up = @receiver.received_reviews.count { |review| review.thumb? }
    @receiver.review_score = (thumbs_up / total_size.to_f) * 100
    @receiver.save
  end

  def review_params
    params.require(:user_review).permit(:serve, :thumb, :volley, :return, :forehand, :backhand,
                                        :speed, :power, :endurance, :content)
  end

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_receiver
    @receiver = @challenge.other_user(current_user)
  end

  def skills_set_update
    @receiver_skills = ComputedSkillsSet.where(user_id: @receiver.id)[0]
    length = @receiver_skills.user.received_reviews.length
    user_review = params[:user_review]

    avg_serve_score = @receiver_skills.serve
    new_serve_score = user_review[:serve].to_f
    @receiver_skills.serve = final_score(avg_serve_score, new_serve_score, length)

    avg_return_score = @receiver_skills.return
    new_return_score = user_review[:return].to_f
    @receiver_skills.return = final_score(avg_return_score, new_return_score, length)

    avg_forehand_score = @receiver_skills.forehand
    new_forehand_score = user_review[:forehand].to_f
    @receiver_skills.forehand = final_score(avg_forehand_score, new_forehand_score, length)

    avg_backhand_score = @receiver_skills.backhand
    new_backhand_score = user_review[:backhand].to_f
    @receiver_skills.backhand = final_score(avg_backhand_score, new_backhand_score, length)

    avg_volley_score = @receiver_skills.volley
    new_volley_score = user_review[:volley].to_f
    @receiver_skills.volley = final_score(avg_volley_score, new_volley_score, length)

    avg_speed_score = @receiver_skills.speed
    new_speed_score = user_review[:speed].to_f
    @receiver_skills.speed = final_score(avg_speed_score, new_speed_score, length)

    avg_power_score = @receiver_skills.power
    new_power_score = user_review[:power].to_f
    @receiver_skills.power = final_score(avg_power_score, new_power_score, length)

    avg_endurance_score = @receiver_skills.endurance
    new_endurance_score = user_review[:endurance].to_f
    @receiver_skills.endurance = final_score(avg_endurance_score, new_endurance_score, length)

    @receiver_skills.save
  end

  def final_score(oldavgscore, newskillscore, length)
    final_score = (oldavgscore * (length - 1) + newskillscore) / length
  end
end
