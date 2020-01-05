class UserReviewsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(review_params)
    @user_review.receiver = User.find(params[:user_id])
    @user_review.sender = current_user
    if @user_review.save
      inform_receiver
      redirect_to user_path(@user_review.receiver)
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

  def final_score(oldavgscore, newskillscore, length)
    final_score = (oldavgscore * (length - 1) + newskillscore) / length
  end

  def inform_receiver
    UserMailer.with(
      sender: @user_review.sender,
      receiver: @user_review.receiver,
      user_review: @user_review
    ).new_player_review.deliver_now unless @user_review.receiver.settings[:new_player_review_email] == false
  end
end
