class SignUpsController < ApplicationController
  def new
  end

  def show
    redirect_to edit_finish_profile_path
  end
end
