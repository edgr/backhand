class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :step1, :step2, :step3

  def show
    @user = current_user
    if step == :step1 && @user.status == 'step1'
      skip_step
    elsif step == :step1 && @user.status == 'step2'
      jump_to(:step3)
    end
    render_wizard
  end

  def update
    @user = current_user
    @user.status = step.to_s
    @user.status = 'active' if step == steps.last
    @user.update_attributes(user_params)
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :country, :place_of_birth, :birthday, :gender, :height, :weight, :level, :style_of_play, :handedness, :backhand_style, :picture, :bio)
  end
end
