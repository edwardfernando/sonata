class SchedulesController < ApplicationController

  before_filter :authenticate_person!, except: [:confirm_from_email_view, :reject_from_email_view, :confirm_from_email, :reject_from_email]
  after_action :verify_authorized, except: [:confirm_from_email_view, :reject_from_email_view, :confirm_from_email, :reject_from_email]

  def show
  end

  def propose_change_schedule
    schedule = Schedule.where(random_id: params[:id]).first
    authorize schedule

    person_with_same_skillsets = Person.joins(:skillsets).where("skillsets.role_id = ? and people.id != ?", schedule.role, current_person)

    respond_to do |format|
      format.json{
        render json: {
          :requested_role => schedule.role.name,
          :person_with_same_skillsets => person_with_same_skillsets,
          :url => service_schedule_path(schedule.service, schedule)
        }
      }
    end
  end

  def process_change_schedule

  end

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
      schedule = Schedule.create(person: person, role: role, service: service, created_by:current_person)
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
    schedule.update(:status => :confirmed, :status_date => Time.now)
    schedule.create_activity action: :confirmed, owner: current_person, recipient: schedule.service
    redirect_to profile_path
  end

  def reject
    schedule = Schedule.find(params[:id])
    authorize schedule
    schedule.update(:status => :rejected, :status_date => Time.now, :reasons => params[:schedule][:reasons])
    schedule.create_activity action: :rejected, owner: current_person, recipient: schedule.service
    ScheduleRejectedMailer.notify(schedule).deliver
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

  def confirm_from_email
    entered_email = params[:person][:email]
    @schedule = Schedule.where(random_id: params[:random_id]).first

    if entered_email.to_s != @schedule.person.email.to_s
      flash[:danger] = "Your email is invalid."
    else
      @schedule.update(:status => :confirmed, :status_date => Time.now)
      @schedule.create_activity action: :confirmed, owner: @schedule.person, recipient: @schedule.service
      flash[:info] = "You've confirmed the following schedule"
    end

    redirect_to confirm_from_email_path
  end

  def reject_from_email
    entered_email = params[:person][:email]
    @schedule = Schedule.where(random_id: params[:random_id]).first

    if entered_email.to_s != @schedule.person.email.to_s
      flash[:danger] = "Your email is invalid."
    else
      @schedule.update(:status => :rejected, :status_date => Time.now, :reasons => params[:person][:reason])
      @schedule.create_activity action: :rejected, owner: @schedule.person, recipient: @schedule.service
      ScheduleRejectedMailer.notify(@schedule).deliver
      flash[:info] = "You've rejected the following schedule"
    end

    redirect_to confirm_from_email_path
  end

  def confirm_from_email_view
    @schedule = Schedule.where(random_id: params[:random_id]).first

    # unless @schedule.waiting?
    #   reject_confirmation_request
    # end

  end

  def reject_from_email_view
    @schedule = Schedule.where(random_id: params[:random_id]).first

    # puts @schedule.to_yaml
    #
    # unless @schedule.waiting?
    #   reject_confirmation_request
    # end

  end

  private
  def reject_confirmation_request
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/schedule_invalid", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end
