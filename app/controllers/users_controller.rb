class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search]
      @users = SearchUsers.new(params[:search]).call
    else
      @users = User.all
    end
    update_ranking
  end

  def show
    @user = User.find(params[:id])
    @reviews = UserReview.where(receiver_id: @user.id)
  end

  private

  def update_ranking
    @users = User.all
    @users = @users.sort_by { |user| user.points }
    counter = 1
    @users.each do |user|
      user.update(ranking: counter)
      user.save
      counter += 1
    end
  end
end
