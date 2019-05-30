class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search].present?
      params[:search].delete("")
      @users = User.search_user_fields(params[:search])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver_id: @user.id)
  end
end
