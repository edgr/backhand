class MatchResultsController < ApplicationController
  before_action :set_match_and_result

  def confirm
    update_players_points
    @match_result.update(confirmed: true)
    redirect_to matches_path
  end

  def update_players_points
    elo_points(@match.player_1.points, @match.player_2.points)
    @match.player_1.points = @new_player_1_points
    @match.player_1.save
    @match.player_2.points = @new_player_2_points
    @match.player_2.save
  end

  private

  def set_match_and_result
    @match = Match.find(params[:id])
    @match_result = @match.match_result
  end

  def elo_points(player_1_points, player_2_points)

    # using https://metinmediamath.wordpress.com/2013/11/27/how-to-calculate-the-elo-rating-including-example/

    transformed_rating_player_1 = 10**(player_1_points / 400)
    transformed_rating_player_2 = 10**(player_2_points / 400)

    probability_player_1 = transformed_rating_player_1 / (transformed_rating_player_1 + transformed_rating_player_2)
    probability_player_2 = transformed_rating_player_2 / (transformed_rating_player_1 + transformed_rating_player_2)

    if player_1_points < 2100.to_f
      k_player_1 = 32.to_f
    elsif player_1_points > 2400.to_f
      k_player_1 = 16.to_f
    else
      k_player_1 = 24.to_f
    end

    if player_2_points < 2100.to_f
      k_player_2 = 32.to_f
    elsif player_2_points > 2400.to_f
      k_player_2 = 16.to_f
    else
      k_player_2 = 24.to_f
    end

    if @match.match_result.winner_id == @match.player_1.id
      s_player_1 = 1.to_f
      s_player_2 = 0.to_f
    else
      s_player_1 = 0.to_f
      s_player_2 = 1.to_f
    end

    @new_player_1_points = player_1_points + k_player_1 * (s_player_1 - probability_player_1)
    @new_player_2_points = player_2_points + k_player_2 * (s_player_2 - probability_player_2)
  end
end
