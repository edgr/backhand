class SignUpsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_creation_params)
      redirect_to edit_finish_profile_path
    else
      render :edit
    end
  end

  private

  def user_creation_params
    params.require(:user).permit(:first_name, :last_name, :level, :address, :phone_number)
  end
end
