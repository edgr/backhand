class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  # after_action :set_query_indication, only: :index

  def index
    if params[:search]
      @query = format_query(params[:search])
      @users = SearchUsers.new(params[:search]).call
    else
      @users = User.all
    end
    respond_to do |format|
      format.html
      format.js
    end

    update_ranking
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver_id: @user.id)
    @progressbar = ((@user.challenges_won.count / @user.all_challenges.count.to_f) * 100).to_i
  end

  # def edit
  # end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to user_path(@user)
  #   else
  #     render :edit
  #   end
  # end

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
    @indication = location.present? ? "in #{location}"  : "matching your query"
  end


  def update_ranking
    @users = @users.sort_by { |user| user.points }
    counter = 1
    @users.each do |user|
      user.update(ranking: counter)
      user.save
      counter += 1
    end
  end
end
