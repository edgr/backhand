class EventsController < ApplicationController
  def player_events
    @events = current_user.all_events.where("date_time >= ?", Date.today)
    raise
  end
end
