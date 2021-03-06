class UserPresenter < BasePresenter
  presents :user
  # For the user show view
  def picture
    h.cl_image_tag(user.picture, angle: 'ignore', secure: true, quality: 'auto', class: 'img-show')
  end

  def card_picture
    h.cl_image_tag(user.try(:picture), angle: 'ignore', secure: true, quality: 'auto', class: 'img')
  end

  def full_name
    "#{user.first_name.titleize} #{user.last_name.titleize}"
  end

  def points
    user.points.to_d.truncate(2).to_f
  end

  def ranking
    user.ranking
  end

  def serve
    (user.computed_skills_set.serve * 10).to_i
  end

  def return
    (user.computed_skills_set.return * 10).to_i
  end

  def forehand
    (user.computed_skills_set.forehand * 10).to_i
  end

  def backhand
    (user.computed_skills_set.backhand * 10).to_i
  end

  def volley
    (user.computed_skills_set.volley * 10).to_i
  end

  def speed
    (user.computed_skills_set.speed * 10).to_i
  end

  def power
    (user.computed_skills_set.power * 10).to_i
  end

  def endurance
    (user.computed_skills_set.endurance * 10).to_i
  end

  def country_code
    country_name = I18nData.countries[user.country]&.downcase
    code = ISO3166::Country.find_country_by_name(country_name)
    code&.alpha3
  end

  def club
    Club.find(user.club_id).name
  end

  def plays_at
     "#{I18n.t('.member_at').to_s} #{user.club.name}" if user.club.present?
  end

  def level(player_level)
    I18n.t(player_level)
  end

  def style(player_style)
    I18n.t(player_style)
  end

  def backhand_style(player_backhand_style)
    I18n.t(player_backhand_style)
  end

  def handedness(player_handedness)
    I18n.t(player_handedness)
  end

  def city(address)
    location = Geocoder.search(address).first
    "#{location.city}, #{location.country}"
  end

  def club_ranking(club_users, user)
    club_users.map(&:id).index(user.id) + 1
  end
end
