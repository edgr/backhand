class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match_result = MatchResult.create(match: @match)
    @match.player_1 = current_user
    # @match.match_result = @match_result

    if @match.save!
      @match_result = MatchResult.create(match: @match, winner: @match.player_1, loser: @match.player_2)
      redirect_to matches_path
    else
      render :new
    end
  end

  def index
    @matches = Match.where("player_1_id = ? OR player_2_id = ?", current_user, current_user)
  end

  private

  def match_params
    params.require(:match).permit(:date, :club_id, :player_2_id)
  end
end
