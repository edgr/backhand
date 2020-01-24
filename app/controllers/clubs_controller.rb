class ClubsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    address = request.location.city
    @clubs = Club.near(address, 25)
    if params[:search_clubs].present?
      @clubs = Club.near(params[:search_clubs][:location], 25)
    else
      @clubs = Club.all
    end
    @markers = @clubs.map do |club|
      {
        lat: club.latitude,
        lng: club.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { club: club })
      }
    end
  end

  def show
    @club = Club.find_by(slug: params[:slug])
    @marker = {
      lat: @club.latitude,
      lng: @club.longitude
    }
  end
end
