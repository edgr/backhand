class RegistrationsController < Devise::RegistrationsController

  private

  def after_sign_up_path_for(resource)
    user_steps_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
