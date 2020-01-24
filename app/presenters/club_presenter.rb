class ClubPresenter < BasePresenter
  presents :club
  # For the club show and index views
  def players_count
    I18n.t('.player_count', count: club.users.count).to_s
  end

  def courts
    "#{I18n.t('courts_count', count: club.courts.count)} (#{courts_type(club.courts)})"
  end

  def courts_indoors
    I18n.t('indoors_count', count: club.courts_indoors.count).to_s
  end

  def courts_with_lights
    I18n.t('.with_lights', count: club.courts_with_lights.count).to_s
  end

  def singles_courts
    I18n.t('singles_only', count: club.singles_courts.count).to_s
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
