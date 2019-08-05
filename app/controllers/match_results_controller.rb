class MatchResultsController < ApplicationController
  def create
    @match = Match.find(params[:match_id])
    @match_result = MatchResult.new
    @match_result.match = @match
    @match_result.save
  end
end
