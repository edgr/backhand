class ClubPresenter < BasePresenter
  presents :club
  # For the user show view
  def players_count
    "#{club.users.count} players" unless club.users.count == 0
  end
end
