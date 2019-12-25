class ShoutoutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @shoutout = Shoutout.new
  end

  def index
    shoutouts = Shoutout.recent.order(created_at: :desc)
    @shoutouts = shoutouts_to_display(shoutouts)
  end

  def create
    @shoutout = Shoutout.new(shoutout_params)
    @shoutout.user = current_user
    @shoutout.recipients = recipients(params[:shoutout][:recipients])
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

  def recipients(user_choice)
    if user_choice == "0"
      recipients = User.where(club_id: current_user.club.id)
    else
      recipients = User.all
    end
    range = params[:shoutout][:minimum_level].to_i..params[:shoutout][:maximum_level].to_i
    return recipients.map do |recipient|
      recipient.id if range.include? recipient.points.to_i
    end.compact
  end

  def shoutouts_to_display(shoutouts_list)
    shoutouts_to_display = []
    shoutouts_list.each do |shoutout|
      if shoutout.recipients.include? current_user.id
        shoutouts_to_display << shoutout
      elsif shoutout.user == current_user
        shoutouts_to_display << shoutout
      end
    end
  end
end
