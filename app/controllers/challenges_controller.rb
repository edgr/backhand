class ChallengesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_challenge, only: %i[show update accept decline cancel]

  def index
    @unplayed_challenges = Challenge.where.not(status: "played")
    @played_challenges = Challenge.where(status: "played")
  end

  def show
    if @challenge.status == "accepted" || @challenge.status == "pending"
      @challenger = User.find(@challenge.challenger_id)
      @challengee = User.find(@challenge.challengee_id)
      @challenge
    else
      redirect_to challenges_path
    end
  end

  def create
    @challenge = Challenge.new
    @challenge.challengee = User.find(params[:user_id])
    @challenge.challenger = current_user
    @challenge.status = "pending"
    if @challenge.valid?
      @challenge.save
      redirect_to challenge_path(@challenge)
    else
      redirect_to user_path(@challenge.challengee)
    end
  end

  def accept
    @challenge.status = "accepted"
    @challenge.save
    redirect_to challenge_path(@challenge)
  end

  def decline
    @challenge.status = "declined"
    @challenge.save
    redirect_to challenges_path
  end

  def cancel
    @challenge.status = "canceled"
    @challenge.save
    redirect_to challenges_path
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
