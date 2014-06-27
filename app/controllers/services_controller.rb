require 'date'

class ServicesController < ApplicationController

	before_filter :authenticate_person!, except: [:index, :show]
	after_action :verify_authorized, except: [:index, :show]

	def index
		date = params[:date]

		respond_to do |format|
			format.html {
					if date == nil
						@services = Service.all.order(date: :desc)
					elsif date.empty?
						@services = Service.where(:date => today)
					else
						@services = Service.where(:date => date)
					end
			}

			format.json {
					@services = Service.all
			}
		end



	end

	def new
		@service = Service.new
		authorize @service
	end

	def create
		@service = Service.new(service_param)
		authorize @service

		role_array = params[:service][:role] ||= []
		people_array = params[:service][:person] ||= []

		role_array.delete_if(&:empty?)
		people_array.delete_if(&:empty?)

		if !@service.valid?
			render "new"
		elsif !role_array.any? || !people_array.any?
			@service.errors.add(:schedules)
			render "new"
		else
			# Service.find(params[:id]).schedules.destroy_all

			role_array.each_with_index do |role,index|
				person = Person.find(people_array[index])
				role = Role.find(role)

				schedule = Schedule.create(service:@service, role:role, person:person)
				ScheduleMailer.new_schedule_notification(schedule).deliver

			end

			@service.save(service_param)
			redirect_to services_path + "?date=" + @service.date.strftime("%F")
		end

	end

	def show
		@service = Service.find(params[:id])
		@status = true

		@service.schedules.each do |s|
			@status = false unless s.is_confirmed?
		end
	end

	def edit
		@service = Service.find(params[:id])
		authorize @service
	end

	def update
		@service = Service.find(params[:id])
		authorize @service

		role_array = params[:service][:role] ||= []
		people_array = params[:service][:person] ||= []
		confirmation_array = params[:service][:isConfirmed] ||= []

		role_array.delete_if(&:empty?)
		people_array.delete_if(&:empty?)
		confirmation_array.delete_if(&:empty?)

		if !@service.update(service_param)
			render "edit"
		elsif !role_array.any? || !people_array.any?
			@service.errors.add(:schedules)
			render "edit"
		else

			# Remove all unconfirmed schedules from particular service because we're going to overide it
			Schedule.where(service: @service, confirmed_at: nil).destroy_all

			role_array.each_with_index do |role,index|

				if confirmation_array[index] == "false"
					person = Person.find(people_array[index])
					role = Role.find(role_array[index])

					begin
						schedule = Schedule.create(service:@service, role:role, person:person)
						ScheduleMailer.new_schedule_notification(schedule).deliver
					rescue ActiveRecord::RecordNotUnique => error
						@service.errors.add(:schedules, " - You already assigned #{person.name} as #{role.name}. Operation canceled.")
						render "edit"
						return false
					end
				end

			end

			@service.update(service_param)

			redirect_to services_path + "?date=" + @service.date.strftime("%F")
		end

	end

	def destroy
		@service = Service.find(params[:id])
		authorize @service

		@service.destroy
		redirect_to services_path
	end

	private
	def service_param
		params.require(:service).permit(:name, :description, :date)
	end

end
