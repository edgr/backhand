class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def welcome
    send_welcome_email
    # redirect_to root_path
  end

  private

  def send_welcome_email
    UserMailer.with(user: current_user).welcome.deliver_later
  end
end
