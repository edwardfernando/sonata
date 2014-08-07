class WelcomeController < ApplicationController

  def index
    @activities = PublicActivity::Activity.page(params[:page]).per(10).order("created_at desc")
  end

  def login
  end

  def destroy
    reset_session
    flash[:success] = "Log out succeffully"
    redirect_to root_path
  end
end
