class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show rankings]
  # after_action :set_query_indication, only: :index

  def index
    if params[:search]
      @query = format_query(params[:search])
      @users = SearchUsers.new(params[:search]).call
    else
      @users = User.active
    end
    seed = set_seed
    @users = @users.select(["setseed(.#{seed})", '*']).order(Arel.sql("RANDOM()")).paginate(page: params[:page], per_page: 12)
    respond_to :html, :js
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver: @user)
    @played_matches = @user.matches_won + @user.matches_lost
    @progressbar = calculate_progressbar(@user) if @user.present? && @played_matches.size.positive?
  end

  def rankings
    @users = User.active.order(ranking: :asc)
    @club_users = User.active.where(club_id: current_user.club_id).order(ranking: :asc) if current_user
  end

  private

  def set_seed
    the_seed = cookies[:user_seed].to_i || Time.now.to_i.abs / 3600
    hours_since_seed = ((Time.now.to_i.abs + 10) / 3600) - the_seed
    expired_seed = hours_since_seed > 1
    no_seed = cookies[:user_seed].nil? || cookies[:user_seed].blank?
    if expired_seed || no_seed
      the_seed = Time.now.to_i.abs / 3600
      cookies[:user_seed] = the_seed
    end
    return the_seed
  end

  def format_query(params)
    return unless params[:query].present?
    set_query_indication
    params[:query] = [params[:query]].flatten.reject(&:blank?).join(" ")
  end

  def set_query_indication
    location = params[:search].try(:[], :location)
    @indication = location.present? ? t('.search_results_location', location: location) : t('.matching_query')
  end

  def calculate_progressbar(user)
    played_matches = user.matches_won + user.matches_lost
    ((user.matches_won.count / played_matches.count.to_f) * 100).to_i
  end
end
