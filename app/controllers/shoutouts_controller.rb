class ShoutoutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @shoutout = Shoutout.new
  end

  def index
    @shoutouts = Shoutout.all.order(created_at: :desc)
  end

  def create
    @shoutout = Shoutout.new(shoutout_params)
    @shoutout.user = current_user
    if @shoutout.save!
      redirect_to shoutouts_path
    else
      render :new
    end
  end

  private

  def shoutout_params
    params.require(:shoutout).permit(:minimum_level, :message, :recipients)
  end
end
