class SchedulesController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def confirm
    schedule = Schedule.find(params[:id])
    authorize schedule

    schedule.update(:is_confirmed => true, :confirmed_at => Time.now)

    schedule.create_activity action: :confirmed, owner: current_person

    redirect_to profile_path
  end

  def reject
    schedule = Schedule.find(params[:id])
    authorize schedule

    schedule.update(:is_confirmed => false, :confirmed_at => Time.now, :reasons => params[:schedule][:reasons])

    schedule.create_activity action: :rejected, owner: current_person

    redirect_to profile_path
  end

end
