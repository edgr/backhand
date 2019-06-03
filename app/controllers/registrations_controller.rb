class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(user)
    edit_sign_up_path(current_user)
  end
end
