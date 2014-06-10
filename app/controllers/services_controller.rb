require 'date'

class ServicesController < ApplicationController

	before_filter :authenticate_person!, except: [:index, :show]
	after_action :verify_authorized, except: [:index, :show]

	def index
		date = params[:date]

		if date == nil
			@services = Service.all.order(date: :desc)
		elsif date.empty?
			@services = Service.where(:date => today)
		else
			@services = Service.where(:date => date)
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
			@service.save(service_param)
			# Service.find(params[:id]).schedules.destroy_all

			role_array.each_with_index do |role,index|
				person = Person.find(people_array[index])
				schedule = Schedule.create(service:@service, role:Role.find(role), person:person)
			end

			redirect_to services_path + "?date=" + @service.date.strftime("%F")
		end

	end

	def show
		@service = Service.find(params[:id])
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

		role_array.delete_if(&:empty?)
		people_array.delete_if(&:empty?)


		if !@service.update(service_param)
			render "edit"
		elsif !role_array.any? || !people_array.any?
			@service.errors.add(:schedules)
			render "edit"
		else

			@service.update(service_param)
			Service.find(params[:id]).schedules.destroy_all

			role_array.each_with_index do |role,index|
				person = Person.find(people_array[index])
				schedule = Schedule.create(service:@service, role:Role.find(role), person:person)
			end

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
