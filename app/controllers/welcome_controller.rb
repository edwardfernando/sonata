class WelcomeController < ApplicationController

  before_filter :authenticate_person!, except: [:index, :login, :destroy]
  after_action :verify_authorized, except: [:index, :login, :destroy]

  def index
    if person_signed_in?
      redirect_to activities_path
    else
      render :layout => false
    end
  end

  def activities
    @activities = PublicActivity::Activity.page(params[:page]).per(10).order("created_at desc")

    @upcoming_schedules = Schedule.joins(:service).joins(:person).where("status = ? and services.date between ? and ? and people.id = ?", 1, Date.today, Date.today + 7, current_person);

    authorize @activities
  end

  def login
  end

  def destroy
    reset_session
    flash[:success] = "Log out succeffully"
    redirect_to root_path
  end
end
