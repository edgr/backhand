class ClubsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
  end
end
