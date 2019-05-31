class FinishProfilesController < ApplicationController
  def edit
    @user = current_user

  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:image, :style_of_play, :handedness,
                                 :backhand_style, :club_id, :gender, :height, :weight, :birthday,
                                 :place_of_birth, :country, :bio)
  end
end
