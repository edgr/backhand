class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(resource)
    user_steps_path
  end
end
