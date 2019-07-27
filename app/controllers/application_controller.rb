class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def after_sign_in_path_for(resource)
    if resource.status == 'active'
      root_path
    else
      user_steps_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :level, :address, :phone_number, :picture, :style_of_play, :handedness, :backhand_style, :gender, :height, :weight, :birthday, :place_of_birth, :country, :bio])
  end
end
