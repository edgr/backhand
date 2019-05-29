class ChallengesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_challenge, only: %i[show update accept decline cancel]

  def index
    @challenges = Challenge.all
  end

  def show
  end

  def create
    @challenge = Challenge.new
    @challenge.challengee = User.find(params[:user_id])
    @challenge.challenger = current_user
    @challenge.status = "Pending"
    if @challenge.valid?
      @challenge.save
      redirect_to challenge_path(@challenge)
    else
      redirect_to user_path(@challenge.challengee)
    end
  end

  def accept
    @challenge.status = "Accepted"
    @challenge.save
    redirect_to challenges_path(@challenge)
  end

  def decline
    @challenge.status = "Declined"
    @challenge.save
    redirect_to challenges_path
  end

  def cancel
    @challenge.status = "Canceled"
    @challenge.save
    redirect_to challenges_path
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
