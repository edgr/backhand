class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  # after_action :set_query_indication, only: :index

  def index
    if params[:search]
      @query = format_query(params[:search])
      @users = SearchUsers.new(params[:search]).call
    else
      @users = User.where(status: "active")
      update_ranking
    end
    respond_to do |format|
      format.html
      format.js
    end
    @users = @users.sort_by { |user| user.points }.reverse
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
    @users = User.where(status: "active")
    update_ranking
    @users = @users.sort_by { |user| user.ranking }
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
    @indication = location.present? ? "in #{location}" : "matching your query"
  end

  def update_ranking
    @users = @users.sort_by { |user| user.points }.reverse
    counter = 1
    @users.each do |user|
      user.update(ranking: counter)
      user.save
      counter += 1
    end
  end
end
