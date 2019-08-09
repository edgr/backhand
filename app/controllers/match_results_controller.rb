class MatchResultsController < ApplicationController
  before_action :set_match_and_result

  def confirm
    @match_result.update(confirmed: true)
    redirect_to matches_path
  end

  private

  def set_match_and_result
    @match = Match.find(params[:id])
    @match_result = @match.match_result
  end
end
