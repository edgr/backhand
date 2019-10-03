class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.player_1 = current_user
    if @event.save
      redirect_to user_my_agenda_path(current_user)
    else
      render :new
    end
  end

  def player_events
    @events = current_user.all_events.order(date_time: :asc)
  end

  private

  def event_params
    params.require(:event).permit(
      :player_2_id, :player_3_id, :player_4_id,
      :date_time, :club_id
    )
  end
end
