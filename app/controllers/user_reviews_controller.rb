class UserReviewsController < ApplicationController
  before_action :set_receiver, only: [:create]

  def create
    @review = Review.new
    @sender = current_user
    @challenge = Challenge.find(params[:challenge_id])
    if @review.save
      redirect_to user_path(@receiver)
    else
      redirect_to challenge_user_review_path(@receiver)
    end
  end

  def destroy
    UserReview.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end

  private

  def set_receiver
    @receiver = @challenge.other_user(current_user)
  end
end
