class ClubsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @clubs = Club.geocoded
    @markers = @clubs.map do |club|
      {
        lat: club.latitude,
        lng: club.longitude
      }
    end
  end

  def show
    @club = Club.find(params[:id])
    @marker = {
      lat: @club.latitude,
      lng: @club.longitude
    }
  end
end
