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
        if set.player_1_games.present?
          @match_result.winner == current_user ? score += "#{set.player_1_games}-#{set.player_2_games} " : score += "#{set.player_2_games}-#{set.player_1_games} "
        end
      end
      @match_result.update(match: @match, score: score.chomp(' '))
      redirect_to matches_path
    else
      render :new
    end
  end

  def index
    @matches = Match.all.order(date: :desc)
  end

  def player_matches
    @matches = Match.where("player_1_id = ? OR player_2_id = ?", current_user, current_user)
    @won_matches = Match.joins(:match_result).where("winner_id = ? AND confirmed = ?", current_user, true).order(date: :desc)
    @lost_matches = Match.joins(:match_result).where("loser_id = ? AND confirmed = ?", current_user, true).order(date: :desc)
    @pending_matches = []
    @matches.each { |match| @pending_matches << match if match.match_result.confirmed == false }
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
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
