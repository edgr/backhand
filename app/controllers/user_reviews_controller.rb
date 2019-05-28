class UserReviewsController < ApplicationController
  def create
    @review = Review.new
    @sender =
    @receiver = current_user
    @challenge =
  end

  def destroy
    @review.destroy
    redirect_to user_path(@sender)
  end
end
