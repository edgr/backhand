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
    if @challenge.save
      redirect_to challenge_path(@challenge)
    else
      render # showpage of users controller
    end
  end

  def accept
    @challenge.status = "Accepted"
    @challenge.save
    redirect_to
  end

  def decline
    @challenge.status = "Declined"
    @challenge.save
    redirect_to
  end

  def cancel
    @challenge.statur = "Canceled"
    @challenge.save
    redirect_to
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
