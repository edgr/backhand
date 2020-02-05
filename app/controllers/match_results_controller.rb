class MatchResultsController < ApplicationController
  before_action :set_match_and_match_result

  def confirm
    @match_result.confirm
    inform_opponent
    redirect_to my_matches_path
  end

  def update_points
    @match_result.update_players_points
  end

  private

  def set_match_and_match_result
    @match_result = MatchResult.find(params[:id])
  end

  def inform_opponent
    UserMailer.with(
      player_1: @match_result.match.player_1,
      player_2: @match_result.match.player_2,
      match_result: @match_result
    ).confirmed_match_result.deliver_later unless @match_result.match.player_1.settings[:confirmed_match_result_email] == false
  end
end
