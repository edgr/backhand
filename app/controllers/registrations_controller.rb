class RegistrationsController < Devise::RegistrationsController
  # DELETE /resource
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def after_sign_up_path_for(resource)
    resource.settings[:language] = locale.to_s
    current_user.save!
    user_steps_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
