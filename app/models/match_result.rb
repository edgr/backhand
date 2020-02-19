class MatchResult < ApplicationRecord
  belongs_to :match, optional: true
  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'

  def confirm
    update_players_points
    update_players_levels
    self.update(confirmed: true)
  end

  def update_players_points
    points = EloPointsCalculator.new(the_match, the_match.player_1.points, the_match.player_2.points)
    the_match.player_1.points = points.calculate_player_1_points
    the_match.player_2.points = points.calculate_player_2_points
    the_match.player_1.save
    the_match.player_2.save
  end

  def update_players_levels
    players = []
    players << the_match.player_1
    players << the_match.player_2

    players.each do |player|
      if player.points >= 2200
        player.level = "pro"
      elsif player.points >= 2000
        player.level = "semi_pro_plus"
      elsif player.points >= 1800
        player.level = "semi_pro"
      elsif player.points >= 1600
        player.level = "expert_plus"
      elsif player.points >= 1400
        player.level = "expert"
      elsif player.points >= 1200
        player.level = "advanced_plus"
      elsif player.points >= 1000
        player.level = "advanced"
      elsif player.points >= 800
        player.level = "intermediate_plus"
      elsif player.points >= 600
        player.level = "intermediate"
      elsif player.points >= 400
        player.level = "beginner_plus"
      elsif player.points >= 0
        player.level = "beginner"
      end
      player.save
    end
  end

  private

  def the_match
    self.match
  end
end
