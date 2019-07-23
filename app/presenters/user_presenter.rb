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

  def country_code
    country_name = I18nData.countries[user.country]&.downcase
    code = ISO3166::Country.find_country_by_name(country_name)
    code&.alpha3
  end
end
