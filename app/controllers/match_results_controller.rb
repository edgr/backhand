class MatchResultsController < ApplicationController
  before_action :set_match_and_result

  def confirm
    update_players_points
    @match_result.update(confirmed: true)
    redirect_to matches_path
  end

  def update_players_points
    points = EloPointsCalculator.new(@match, @match.player_1.points, @match.player_2.points)
    @match.player_1.points = points.calculate_player_1_points
    @match.player_2.points = points.calculate_player_2_points
    @match.player_1.save
    @match.player_2.save
  end

  private

  def set_match_and_result
    @match = Match.find(params[:id])
    @match_result = @match.match_result
  end
end
