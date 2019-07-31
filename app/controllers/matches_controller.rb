class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def index
    @matches = Match.all
  end
end
