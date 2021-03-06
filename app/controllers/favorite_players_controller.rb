class FavoritePlayersController < ApplicationController
  before_action :set_favorited, only: [ :create, :destroy ]

  def create
    Favorite.create(favorited: @favorited_player, user: current_user) if already_favorited.nil?
  end

  def destroy
    Favorite.where(favorited_id: @favorited_player.id, user_id: current_user.id).first.destroy
  end

  def index
    @favorites = current_user.favorite_players
  end

  private

  def set_favorited
    @favorited_player = User.find(params[:id])
  end

  def already_favorited
    Favorite.where(
      favorited_id: @favorited_player.id,
      user_id: current_user.id
    ).first
  end
end
