class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.player = current_user
    # @match.loser
    if @match.save!
      redirect_to matches_path
    else
      render :new
    end
  end

  def index
    @matches = Match.where(player_1: current_user)
    @matches += Match.where(player_2: current_user)
  end

  private

  def match_params
    params.require(:match).permit(:location, :date, :opponent_id, :winner_id, :score)
  end
end
