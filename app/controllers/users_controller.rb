class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # raise
    if params[:search][:location].present?
      @users = User.search_user_fields(params[:search][:location].to_s)
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver_id: @user.id)
  end

  def edit
  end

  def update
  end
end
