class WelcomeController < ApplicationController

  def index
  end

  def login
  end

  def destroy
    reset_session
    flash[:success] = "Log out succeffully"
    redirect_to root_path
  end
end
