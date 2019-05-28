class UserReviewsController < ApplicationController
  def show
  end

  def create
    set_receiver
    @review = Review.new
    @sender = current_user
    @challenge = Challenge.find(params[:challenge_id])
    if @review.safe
      redirect_to user_path(@receiver)
    else
      redirect_to challenge_user_review_path(@receiver)
    end
  end

  def destroy
    @review.destroy
    redirect_to user_path(@receiver)
  end

  private

  def set_receiver
    @receiver = @challenge.other_user(current_user)
  end
end
