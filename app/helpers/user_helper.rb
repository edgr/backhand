module UserHelper
  def force_country(user)
    user.country || "Spain"
  end

  def force_age(user)
    user.age || 99
  end

  def get_picture(user)
    user.picture_url || 'profile.png'
  end
end
