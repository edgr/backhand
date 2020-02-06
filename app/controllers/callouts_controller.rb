class CalloutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def new
    @callout = Callout.new
  end

  def index
    @callouts = callouts_to_display(Callout.recent.order(created_at: :desc))
  end

  def create
    @callout = Callout.new(callout_params)
    @callout.user = current_user
    @callout.recipients = filter_recipients(params[:callout][:recipients])
    raise
    if @callout.save!
      inform_recipients(@callout.recipients)
      redirect_to callouts_path
    else
      render :new
    end
  end

  def destroy
    Callout.find(params[:id]).destroy
    redirect_to callouts_path
  end

  def status
    @callout = Callout.find(params[:id])
    @callout.status = "found"
    @callout.save!
    redirect_to callouts_path
  end

  private

  def callout_params
    params.require(:callout).permit(:minimum_level, :maximum_level, :message)
  end

  def filter_recipients(user_choice)
    if user_choice == "0"
      recipients = current_user.favorite_players
    elsif user_choice == "1"
      recipients = User.active.where(club_id: current_user.club_id)
    else
      recipients = User.active.near(current_user.address, 25)
    end
    recipients = recipients.reject { |recipient| recipient.id == current_user.id }
    range = params[:callout][:minimum_level].to_i..params[:callout][:maximum_level].to_i
    recipients.map do |recipient|
      recipient.id if range.include? recipient.points.to_i
    end.compact
  end

  def inform_recipients(list)
    inviter = User.find(@callout.user_id)
    list.each do |recipient|
      recipient = User.find(recipient)
      UserMailer.with(
        inviter: inviter,
        recipient: recipient,
        callout: @callout
      ).new_callout.deliver_later unless recipient.settings[:new_callout_email] == false
    end
  end

  def callouts_to_display(callouts_list)
    callouts_list.select do |callout|
      if user_signed_in?
        if callout.recipients.include? current_user.id
          callout
        elsif callout.user_id == current_user.id
          callout
        end
      else
        callout
      end
    end
  end
end
