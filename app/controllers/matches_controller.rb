class MatchesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @match = Match.new
    5.times { @match.match_sets.build }
  end

  def create
    @match = Match.new(match_params)
    @match.player_2 = User.find(params[:match][:player_2]) unless params[:match][:player_2].empty?
    params[:match_result][:winner].to_i == current_user.id ? loser_id = params[:match][:player_2].to_i : loser_id = current_user.id
    @match_result = MatchResult.create(match: @match, winner_id: params[:match_result][:winner], loser_id: loser_id)
    @match.player_1 = current_user
    if @match.save
      update_match_result_score
      inform_player_2
      redirect_to user_my_matches_path(current_user)
    else
      render :new
    end
  end

  def index
    @matches = Match.joins(:match_result).where("match_results.confirmed = true").order(date: :desc)
  end

  def player_matches
    @matches = current_user.all_matches
    @won_matches = Match.joins(:match_result).where("winner_id = ? AND confirmed = ?", current_user, true).order(date: :desc)
    @lost_matches = Match.joins(:match_result).where("loser_id = ? AND confirmed = ?", current_user, true).order(date: :desc)
    @pending_matches = current_user.pending_matches
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
  end

  private

  def match_params
    params.require(:match).permit(
      :date, :club_id,
      match_result_attributes: [:id, :winner_id, :_destroy],
      match_sets_attributes: [:id, :player_1_games, :player_2_games, :_destroy]
    )
  end

  def update_match_result_score
    score = ''
    @match.match_sets.each do |set|
      if set.player_1_games.present?
        @match_result.winner == current_user ? score += "#{set.player_1_games}-#{set.player_2_games} " : score += "#{set.player_2_games}-#{set.player_1_games} "
      end
    end
    @match_result.update(match: @match, score: score.chomp(' '))
  end

  def inform_player_2
    UserMailer.with(player_1: @match.player_1, player_2: @match.player_2, match: @match).new_match_result.deliver_now
  end
end
