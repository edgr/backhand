class EventsController < ApplicationController
  def player_events
    @events = Event.all
  end
end
