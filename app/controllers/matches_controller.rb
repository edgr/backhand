class MatchesController < ApplicationController
  def new
    @match = Match.new
    5.times { @match.match_sets.build }
  end

  def create
    @match = Match.new(match_params)
    params[:match_result][:winner].to_i == current_user.id ? loser_id = params[:match][:player_2_id] : loser_id = current_user.id
    @match_result = MatchResult.create(match: @match, winner_id: params[:match_result][:winner], loser_id: loser_id)
    @match.player_1 = current_user
    if @match.save!
      score = ''
      @match.match_sets.each do |set|
        score += "#{set.player_1_games}-#{set.player_2_games} " if set.player_1_games.present?
      end
      @match_result.update(match: @match, score: score.chomp(' '))
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
      match_result_attributes: [:id, :winner_id, :_destroy],
      match_sets_attributes: [:id, :player_1_games, :player_2_games, :_destroy]
    )
  end
end
