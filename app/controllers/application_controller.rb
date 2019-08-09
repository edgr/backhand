class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.status == 'active'
      stored_location_for(resource_or_scope) || super
    else
      user_steps_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :level, :address, :phone_number, :picture, :style_of_play, :handedness, :backhand_style, :gender, :height, :weight, :birthday, :place_of_birth, :country, :bio, :club_id])
  end
end
