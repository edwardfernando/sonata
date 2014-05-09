class ServicesController < ApplicationController

	def index
		@services = Service.all
	end

	def new
	end

	def create
		@service = Service.new(service_param)

		@service.save
		redirect_to @service
	end

	def show
		@service = Service.find(params[:id])
	end

	private
	def service_param
		params.require(:services).permit(:name, :description)
	end

end
