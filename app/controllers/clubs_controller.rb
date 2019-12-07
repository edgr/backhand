class ClubsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @clubs = Club.geocoded
    if params[:search_clubs].nil?
      address = request.location.city
      @clubs = @clubs.near(address, 25)
    elsif params[:search_clubs][:location].present?
      @clubs = @clubs.near(params[:search_clubs][:location], 250)
    else
      @clubs = Club.geocoded
    end
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
