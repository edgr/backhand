class FavoritePlayersController < ApplicationController
  before_action :set_user

  def create
    Favorite.create(favorited: @favorited_player, user: current_user)
  end

  def destroy
    Favorite.where(favorited_id: @favorited_player.id, user_id: current_user.id).first.destroy
  end

  private

  def set_user
    @favorited_player = User.find(params[:id])
  end
end
