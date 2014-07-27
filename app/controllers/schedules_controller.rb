class SchedulesController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def create

    service = Service.find(params[:service_id])
    authorize service

    person = Person.find(params[:person_id])
    role = Role.find(params[:role_id])

    person_role_in_service = Schedule.where(person: person, service: service).first

    if !Schedule.where(person: person, role: role, service: service).first.nil?
      # Check if particular person already assigned to particular role in the same service.
      # Each person can't do same role at the same time
      service.errors.add(:schedules, "You can't assign #{person.name} to #{role.name} at the same time")
      # Check if particular person assigned to any service. Each person can't do more than one role
      # at the same time
    elsif !person_role_in_service.nil?
      service.errors.add(:schedules, "#{person.name} has been assigned as #{person_role_in_service.role.name}. Please choose other person.")
    else
      schedule = Schedule.create(person: person, role: role, service: service)
    end

    # use in create-user ajax (service form page)
    respond_to do |format|

      format.json{
        if !service.errors.empty?
          render json: { :errors => service.errors[:schedules] }, :status => 422
        elsif
          ScheduleMailer.new_schedule_notification(schedule).deliver
          render json: {:schedule => schedule, :url => service_schedule_path(service, schedule)}
        end

      }
    end
  end

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

  def destroy
    schedule = Schedule.where(service: params[:service_id], id: params[:id])
    authorize schedule

    schedule.first.destroy

    respond_to do |format|
      format.html{
        render :nothing => true
      }

      format.js{
      }
    end

  end

end
