class WelcomeController < ApplicationController

  def index
    @activities = PublicActivity::Activity.order("created_at desc").limit(10)
  end

  def login
  end

  def destroy
    reset_session
    flash[:success] = "Log out succeffully"
    redirect_to root_path
  end
end
