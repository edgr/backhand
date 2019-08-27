class MatchResultsController < ApplicationController
  before_action :set_match_and_match_result

  def confirm
    update_players_points
    update_players_levels
    @match_result.update(confirmed: true)
    redirect_to user_my_matches_path(current_user)
  end

  def update_players_points
    points = EloPointsCalculator.new(@match, @match.player_1.points, @match.player_2.points)
    @match.player_1.points = points.calculate_player_1_points
    @match.player_2.points = points.calculate_player_2_points
    @match.player_1.save
    @match.player_2.save
  end

  private

  def update_players_levels
    players = []
    players << @match.player_1
    players << @match.player_2

    players.each do |player|
      if player.points >= 1800
        player.level = "Pro"
      elsif player.points >= 1400
        player.level = "Semi-pro"
      elsif player.points >= 1000
        player.level = "Advanced"
      elsif player.points >= 600
        player.level = "Intermediate"
      elsif player.points >= 0
        player.level = "Beginner"
      end
      player.save
    end
  end

  def set_match_and_match_result
    @match_result = MatchResult.find(params[:id])
    @match = @match_result.match
  end
end
