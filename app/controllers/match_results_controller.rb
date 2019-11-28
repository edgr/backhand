class MatchResultsController < ApplicationController
  before_action :set_match_and_match_result

  def confirm
    @match_result.confirm
    redirect_to user_my_matches_path(current_user)
  end

  def update_points
    @match_result.update_players_points
  end

  private

  def set_match_and_match_result
    @match_result = MatchResult.find(params[:id])
  end
end
