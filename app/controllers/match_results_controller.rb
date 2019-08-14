class MatchResultsController < ApplicationController
  before_action :set_match_result

  def confirm
    @match_result.update(confirmed: true)
    redirect_to matches_path
  end

  private

  def set_match_result
    @match_result = MatchResult.find(params[:id])
  end
end
