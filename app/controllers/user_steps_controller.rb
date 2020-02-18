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
    case step
    when :step2
      set_points
    when :step3
      step3
    end
    @user.update_attributes(user_params)
    User.update_ranking if @user.active?
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :country, :place_of_birth, :birthday, :gender, :height, :weight, :level, :style_of_play, :handedness, :backhand_style, :picture, :bio, :club_id, :angle)
  end

  def set_points
    case params[:user][:level]
    when "beginner"
      @user.points = 200
    when "beginner_plus"
      @user.points = 400
    when "intermediate"
      @user.points = 600
    when "intermediate_plus"
      @user.points = 800
    when "advanced"
      @user.points = 1000
    when "advanced_plus"
      @user.points = 1200
    when "expert"
      @user.points = 1400
    when "expert_plus"
      @user.points = 1600
    when "semi_pro"
      @user.points = 1800
    when "semi_pro_plus"
      @user.points = 2000
    when "pro"
      @user.points = 2200
    end
  end

  def step3
    @user.status = 'active'
  end

  def finish_wizard_path
    welcome_path
  end
end
