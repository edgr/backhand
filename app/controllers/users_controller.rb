class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search].nil?
      @users = User.all
    elsif params[:search].reject(&:blank?).empty?
      @users = User.all
    elsif params[:search].present?
      params[:search].delete("")
      @users = User.search_user_fields(params[:search])
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver_id: @user.id)
    #@search = params[:search]
  end
end
