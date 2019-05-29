class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show update accept decline cancel]

  def index
    @challenges = Challenge.all
    # @dresses = policy_scope(Dress).where(user: current_user)
  end

  def show
  end

  def create
    @challenge = Challenge.new
    @challenger = current_user
    @challengee = User.find(params[:id])
    if @challenge.save
      redirect_to challenge_path(@challenge)
    else
      redirect_to user_path(@challengee)
    end
  end

  def accept
    @challenge.status = "Accepted"
    @challenge.save
    redirect_to # other challenge show page
  end

  def decline
    @challenge.status = "Declined"
    @challenge.save
    redirect_to challenge_path
  end

  def cancel
    @challenge.status = "Canceled"
    @challenge.save
    redirect_to challenge_path
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
