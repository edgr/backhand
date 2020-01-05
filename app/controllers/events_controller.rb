class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.player_1 = current_user
    if @event.save
      inform_players
      redirect_to my_agenda_path
    else
      render :new
    end
  end

  def player_events
    @events = current_user.all_events.order(date_time: :asc)
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to my_agenda_path
  end

  def edit
    @event = Event.find(params[:id]).destroy
  end

  private

  def event_params
    params.require(:event).permit(
      :player_2_id, :player_3_id, :player_4_id,
      :date_time, :club_id
    )
  end

  def inform_players
    UserMailer.with(inviter: @event.player_1, partner: @event.player_2, event: @event).new_game_event.deliver_now
    UserMailer.with(inviter: @event.player_1, partner: @event.player_3, event: @event).new_game_event.deliver_now if @event.player_3.nil? == false
    UserMailer.with(inviter: @event.player_1, partner: @event.player_4, event: @event).new_game_event.deliver_now if @event.player_4.nil? == false
  end
end
