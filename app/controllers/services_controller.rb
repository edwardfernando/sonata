class ServicesController < ApplicationController

	def index
		date = params[:date]

		if date == nil
			@services = Service.all.order(date: :desc)
		else
			@services = Service.where(:date => date)
		end

	end

	def new
		@service = Service.new
	end

	def create
		@service = Service.new(service_param)
		@service.save

		role_array = params[:service][:role] ||= []
		people_array = params[:service][:person] ||= []

		role_array.each_with_index do |role,index|
			Schedule.create(service:@service, role:Role.find(role), person:Person.find(people_array[index]))
		end

		redirect_to services_path
	end

	def show
		@service = Service.find(params[:id])
	end

	def edit
		@service = Service.find(params[:id])
	end

	def update
		@service = Service.find(params[:id])
		@service.update(service_param)

		Service.find(params[:id]).schedules.destroy_all

		role_array = params[:service][:role] ||= []
		people_array = params[:service][:person] ||= []

		role_array.each_with_index do |role,index|
			Schedule.create(service:@service, role:Role.find(role), person:Person.find(people_array[index]))
		end

		redirect_to services_path
	end

	def destroy
		Service.find(params[:id]).destroy
		redirect_to services_path
	end

	private
	def service_param
		params.require(:service).permit(:name, :description, :date)
	end

end
