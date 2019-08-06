class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    params[:winner].to_i == current_user.id ? loser_id = params[:match][:player_2_id] : loser_id = current_user.id
    @match_result = MatchResult.create(match: @match, winner_id: params[:winner], loser_id: loser_id)
    @match.player_1 = current_user
    raise
    if @match.save!
      @match_result.update(match: @match)
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
    params.require(:match).permit(
      :date, :club_id, :player_2_id,
      match_result_attributes: [:winner_id]
    )
  end
end
