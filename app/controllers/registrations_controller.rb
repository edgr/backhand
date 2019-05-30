class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(user)
    new_sign_up_path
  end
end
