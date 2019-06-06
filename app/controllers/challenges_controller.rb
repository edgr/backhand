class ChallengesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_challenge, only: %i[show update accept decline cancel played]

  def index
    @unplayed_challenges = Challenge.where.not(status: "played").where(challenger_id: current_user).or(Challenge.where(challengee_id: current_user))
    @played_challenges = Challenge.where(status: "played").where(challenger_id: current_user).or(Challenge.where(challengee_id: current_user))
  end

  def show
    if @challenge.status == "accepted" || @challenge.status == "pending" || @challenge.status == "played"
      @challenger = @challenge.challenger
      @challengee = @challenge.challengee
      @players = [@challenger, @challengee]
    else
      redirect_to challenges_path
    end
    @user_review = UserReview.new
  end

  def create
    @challenge = Challenge.new
    @challenge.challengee = User.find(params[:user_id])
    @challenge.challenger = current_user
    @challenge.status = "pending"
    if @challenge.valid?
      @challenge.save
      redirect_to challenge_path(@challenge)
    else
      redirect_to user_path(@challenge.challengee)
    end
  end

  def update
    @challenge.update(challenge_params)
    if current_user == @challenge.challengee
      game_value_challenger
    end
    redirect_to new_challenge_user_review_path(@challenge)
  end

  def accept
    @challenge.status = "accepted"
    @challenge.save
    redirect_to challenge_path(@challenge)
  end

  def decline
    @challenge.status = "declined"
    @challenge.save
    redirect_to challenges_path
  end

  def cancel
    @challenge.status = "canceled"
    @challenge.save
    redirect_to challenges_path
  end

  def played
    @challenge.status = "played"
    @challenge.save
    redirect_to challenge_path(@challenge)
  end

  def game_value_challenger
    elo_points(@challenge.challenger.points, @challenge.challengee.points)
    @challenge.challenger.points = @new_challenger_score
    @challenge.challenger.save
    @challenge.challengee.points = @new_challengee_score
    @challenge.challengee.save
  end

  def elo_points(challenger_score, challengee_score)
    difference = challenger_score - challengee_score
    exponent = -(difference / 100.to_f)
    probability = 1.to_f / (1.to_f + (10.to_f ** exponent))

    if challenger_score < 2100.to_f
      k_challenger = 32.to_f
    elsif challenger_score > 2400.to_f
      k_challenger = 16.to_f
    else
      k_challenger = 24.to_f
    end

    if challengee_score < 2100.to_f
      k_challengee = 32.to_f
    elsif challengee_score > 2400.to_f
      k_challengee = 16.to_f
    else
      k_challengee = 24.to_f
    end

    if @challenge.winner == @challenge.challenger.id
      s = 1.to_f
    else
      s = 0.to_f
    end

    @new_challenger_score = challenger_score + k_challenger * (s - probability)
    @new_challengee_score = challengee_score + k_challengee * ((1.to_f - s) - (1.to_f - probability))
  end

  private

  def challenge_params
    params.require(:challenge).permit(:location, :date, :winner, :score, :loser)
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
