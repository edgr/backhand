class CalloutsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :user_is_active, only: %i[new]

  def new
    @callout = Callout.new
    @club_users = User.active.where(club_id: current_user.club_id)
    @users_around = User.active.near(current_user.address, 25)
    @favorites = current_user.favorite_players
    gon.jbuilder
  end

  def index
    @callouts = callouts_to_display(Callout.recent.order(created_at: :desc))
  end

  def create
    @callout = Callout.new(callout_params)
    @callout.user = current_user
    @callout.recipients = filter_recipients(params[:callout][:recipients])
    if @callout.save
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
    if user_choice == "2"
      current_user.favorite_players.map(&:id)
    elsif user_choice == "1"
      recipients = User.active.where(club_id: current_user.club_id)
      filter_by_range(recipients)
    else
      recipients = User.active.near(current_user.address, 25)
      filter_by_range(recipients)
    end
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

  def user_is_active
    if current_user.active? == false
      redirect_to user_steps_path
      flash[:notice] = I18n.t('complete_profile_please')
    end
  end

  def filter_by_range(recipients)
    recipients.reject { |recipient| recipient.id == current_user.id }
    range = params[:callout][:minimum_level].to_i..params[:callout][:maximum_level].to_i
    recipients.map do |recipient|
      recipient.id if range.include? recipient.points.to_i
    end.compact
  end
end
