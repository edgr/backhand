class ClubPresenter < BasePresenter
  presents :club
  # For the user show view
  def players_count
    "#{club.users.count} players" unless club.users.count == 0
  end

  def courts
    "#{club.courts.count} courts (#{courts_type(club.courts)})"
  end

  def courts_indoors
    if club.courts_indoors.count == 0
      "no indoor courts"
    elsif club.courts_indoors.count == 1
      "1 indoor court"
    else
      "#{club.courts_indoors.count} indoor courts"
    end
  end

  def courts_with_lights
    if club.courts_with_lights.count == 0
      "no courts with lights"
    elsif club.courts_with_lights.count == 1
      "1 court with lights"
    else
      "#{club.courts_with_lights.count} court(s) with lights"
    end
  end

  def singles_courts
    if club.singles_courts.count > 0
      "no \'singles only\'"
    elsif club.singles_courts.count == 1
      "1 \'singles only\' court"
    else
      "#{club.singles_courts.count} \"singles only\" court(s)"
    end
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
