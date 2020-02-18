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
    @users = @users.order(Arel.sql("RANDOM()")).paginate(page: params[:page], per_page: 12)
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
  end

  private

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
