class RankingJob < ApplicationJob
  queue_as :default

  def perform
    User.active.ordered_by_points.each_with_index do |user, index|
      user.update(ranking: index + 1)
    end
  end
end
