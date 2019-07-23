class UserPresenter < BasePresenter
  presents :user

  # def edit
  #   h.link_to 'edit', edit_user_path(@user)
  # end

  def picture
    h.cl_image_tag(user.picture, class: "img-b")
  end

  def full_name
    "#{user.first_name} #{user.last_name}"
  end

  def ranking
    user.ranking
  end

  def level
    user.level
  end

  def style
    user.style_of_play
  end

  def points
    user.points.to_d.truncate(2).to_f
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
end
