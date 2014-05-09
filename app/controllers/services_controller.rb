class ServicesController < ApplicationController

	def index
		@services = Service.all
	end

	def new
		@service = Service.new
	end

	def create
		@service = Service.new(service_param)

		@service.save
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
		redirect_to services_path
	end

	def destroy
		Service.find(params[:id]).destroy
		redirect_to services_path
	end

	private
	def service_param
		params.require(:service).permit(:name, :description)
	end

end
