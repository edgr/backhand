class ClubPresenter < BasePresenter
  presents :club
  # For the user show view
  def players_count
    "#{club.users.count} players" unless club.users.count == 0
  end

  def courts
    "#{club.courts.count} courts (#{courts_type(club.courts)})"
  end

  private

  def courts_type(courts)
    clay = []
    hard = []
    grass = []
    carpet = []
    courts.each do |court|
      case court.surface
      when "Clay"
        clay << court
      when "Hard"
        hard << court
      when "Grass"
        grass << court
      when "Carpet"
        carpet << court
      end
    end
    courts = [clay, hard, grass, carpet].reject(&:empty?)
    courts.map do |courts_surface|
      "#{courts_surface.count} #{courts_surface[0].surface.downcase}"
    end.join(', ')
  end
end
