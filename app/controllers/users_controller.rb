class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show rankings]
  # after_action :set_query_indication, only: :index

  def index
    if params[:search]
      @query = format_query(params[:search])
      @users = SearchUsers.new(params[:search]).call
    else
      @users = User.active.ordered_by_points
      update_ranking
    end
    respond_to do |format|
      format.html
      format.js
    end
    @users = @users.ordered_by_points.paginate(page: params[:page], per_page: 12)
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver: @user)
    @played_matches = @user.matches_won + @user.matches_lost
    if @user.present?
      unless @played_matches.count == 0
        @progressbar = ((@user.matches_won.count / @played_matches.count.to_f) * 100).to_i
      end
    end
  end

  def rankings
    @users = User.active
    update_ranking
    @users = @users.ordered_by_points
  end

  private

  def format_query(params)
    return unless params[:query].present?
    set_query_indication
    params[:query] = params[:query].reject do |value|
      value.blank?
    end.join(" ")
  end

  def set_query_indication
    location = params[:search].try(:[], :location)
    @indication = location.present? ? t('.search_results_location', location: location) : t('.matching_query')
  end

  def update_ranking
    @users = @users.ordered_by_points
    @users.each_with_index { |user, index| user.update(ranking: index + 1) }
  end
end
