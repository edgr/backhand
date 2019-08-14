class EloPointsCalculator
  # using https://metinmediamath.wordpress.com/2013/11/27/how-to-calculate-the-elo-rating-including-example/
  def initialize(the_match, player_1_points, player_2_points)
    @player_1_points = player_1_points
    @player_2_points = player_2_points
    @match = the_match
  end

  def calculate_player_1_points
    @player_1_points + k_factor_player_1 * (game_output_player_1 - winning_probability_player_1)
  end

  def calculate_player_2_points
    @player_2_points + k_factor_player_2 * (game_output_player_2 - winning_probability_player_2)
  end

  private

  def transformed_rating_player_1
    10**(@player_1_points / 400)
  end

  def transformed_rating_player_2
    10**(@player_2_points / 400)
  end

  def winning_probability_player_1
    transformed_rating_player_1 / (transformed_rating_player_1 + transformed_rating_player_2)
  end

  def winning_probability_player_2
    transformed_rating_player_2 / (transformed_rating_player_1 + transformed_rating_player_2)
  end

  def game_output_player_1
    if @match.match_result.winner_id == @match.player_1.id
      s_player_1 = 1.to_f
    else
      s_player_1 = 0.to_f
    end
  end

  def game_output_player_2
    if @match.match_result.winner_id == @match.player_1.id
      s_player_2 = 0.to_f
    else
      s_player_2 = 1.to_f
    end
  end

  def k_factor_player_1
    if @player_1_points < 2100.to_f
      k_player_1 = 32.to_f
    elsif player_1_points > 2400.to_f
      k_player_1 = 16.to_f
    else
      k_player_1 = 24.to_f
    end
  end

  def k_factor_player_2
    if @player_2_points < 2100.to_f
      k_player_2 = 32.to_f
    elsif player_2_points > 2400.to_f
      k_player_2 = 16.to_f
    else
      k_player_2 = 24.to_f
    end
  end
end
