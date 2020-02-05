class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show rankings]
  # after_action :set_query_indication, only: :index

  def index
    if params[:search]
      @query = format_query(params[:search])
      @users = SearchUsers.new(params[:search]).call
                          .order(Arel.sql("RANDOM()")).paginate(page: params[:page], per_page: 20)
    else
      @users = User.active
      update_ranking
      @users = @users.order(Arel.sql("RANDOM()")).paginate(page: params[:page], per_page: 20)
    end
    respond_to :html, :js
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver: @user)
    @played_matches = @user.matches_won + @user.matches_lost
    @progressbar = calculate_progressbar(@user) if @user.present? && @played_matches.size.positive?
  end

  def rankings
    @users = User.active.ordered_by_points
    update_ranking
  end

  private

  def format_query(params)
    return unless params[:query].present?
    set_query_indication
    params[:query] = params[:query].reject(&:blank?).join(" ")
  end

  def set_query_indication
    location = params[:search].try(:[], :location)
    @indication = location.present? ? t('.search_results_location', location: location) : t('.matching_query')
  end

  def update_ranking
    @users.ordered_by_points.each_with_index { |user, index| user.update(ranking: index + 1) }
  end

  def calculate_progressbar(user)
    played_matches = user.matches_won + user.matches_lost
    ((user.matches_won.count / played_matches.count.to_f) * 100).to_i
  end
end
