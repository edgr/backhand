class ShoutoutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @shoutout = Shoutout.new
  end

  def index
    @shoutouts = shoutouts_to_display(Shoutout.recent.order(created_at: :desc))
  end

  def create
    @shoutout = Shoutout.new(shoutout_params)
    @shoutout.user = current_user
    @shoutout.recipients = filter_recipients(params[:shoutout][:recipients])
    if @shoutout.save!
      redirect_to shoutouts_path
    else
      render :new
    end
  end

  def destroy
    Shoutout.find(params[:id]).destroy
    redirect_to shoutouts_path
  end

  private

  def shoutout_params
    params.require(:shoutout).permit(:minimum_level, :maximum_level, :message)
  end

  def filter_recipients(user_choice)
    if user_choice == "0"
      recipients = User.where(club_id: current_user.club.id)
    else
      recipients = User.near(current_user.address, 25)
    end
    recipients = recipients.reject { |recipient| recipient.id == current_user.id }
    range = params[:shoutout][:minimum_level].to_i..params[:shoutout][:maximum_level].to_i
    return recipients.map do |recipient|
      recipient.id if range.include? recipient.points.to_i
    end.compact
  end

  def shoutouts_to_display(shoutouts_list)
    shoutouts_list.select do |shoutout|
      if user_signed_in?
        if shoutout.recipients.include? current_user.id
          shoutout
        elsif shoutout.user_id == current_user.id
          shoutout
        end
      else
        shoutout
      end
    end
  end
end
