class ShoutoutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @shoutout = Shoutout.new
  end

  def index
    @shoutouts = Shoutout.recent.order(created_at: :desc)
  end

  def create
    @shoutout = Shoutout.new(shoutout_params)
    @shoutout.user = current_user
    @shoutout.recipients = recipients
    if @shoutout.save!
      redirect_to shoutouts_path
    else
      render :new
    end
  end

  private

  def shoutout_params
    params.require(:shoutout).permit(:minimum_level, :maximum_level, :message)
  end

  def recipients
    club_id = current_user.club.id
    if params[:shoutout][:recipients] == "0"
      recipients = User.where(club_id: club_id)
    elsif params[:shoutout][:recipients] == "1"
      recipients = User.where.not(club_id: club_id)
    else
      recipients = User.all
    end
    recipients.map do |recipient|
      recipient.id
    end
  end
end
