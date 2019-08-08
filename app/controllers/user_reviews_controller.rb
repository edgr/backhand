class UserReviewsController < ApplicationController
  before_action :set_receiver, only: [:create]

  def new
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(review_params)
    @sender = current_user
    @user_review.sender_id = @sender.id
    @user_review.receiver_id = @receiver.id
    if @user_review.save
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

  def review_params
    params.require(:user_review).permit(:serve, :thumb, :volley, :return, :forehand, :backhand,
                                        :speed, :power, :endurance, :content)
  end

  def set_receiver
    @receiver = @challenge.other_user(current_user)
  end

  def final_score(oldavgscore, newskillscore, length)
    final_score = (oldavgscore * (length - 1) + newskillscore) / length
  end
end
