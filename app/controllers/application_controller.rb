class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context
  around_action :switch_locale

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def switch_locale(&action)
    locale = current_user.present? ? current_user.settings[:language] : params[:locale]
    I18n.with_locale(locale, &action)
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
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:first_name, :last_name, :level, :address, :phone_number, :picture, :style_of_play, :handedness, :backhand_style, :gender, :height, :weight, :birthday, :place_of_birth, :country, :bio, :club_id, :angle, :new_shoutout_email, :new_game_event_email, :new_match_result_email, :new_player_review_email, :confirmed_match_result_email, :language, :show_my_whatsapp)
    end
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
end
