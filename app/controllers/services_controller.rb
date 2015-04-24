require 'date'

class ServicesController < ApplicationController

	before_filter :authenticate_person!
	after_action :verify_authorized

	def index
		date = params[:date]

		respond_to do |format|
			format.html {
				# @services = Service.order("date asc").limit(5)

				# if date == nil
				# 	@services = Service.all.order(date: :desc)
				# elsif date.empty?
				# 	@services = Service.where(:date => today)
				# else
				# 	@services = Service.where(:date => date)
				# end
				authorize current_person
			}

			format.json {
					start_date = Time.at(params[:start].to_i).to_date
					end_date = Time.at(params[:end].to_i).to_date

					@services = Service.where(:date => start_date..end_date)
					authorize current_person
			}
		end

	end

	def show_new_calendar

		respond_to do |format|

			format.html {
				authorize Service.new
			}

			format.json {
				start_date = Time.at(params[:from].to_i/1000).to_date
				end_date = Time.at(params[:to].to_i/1000).to_date


				puts "start date #{start_date} \n end date #{end_date}"

				@services = Service.where(:date => start_date..end_date)
				authorize @services

				# puts "services : #{@services.to_json}"

				# render :json => '{"success":1,"result":[{"id":"293","title":"This is warning class event with very long title to check how it fits to evet in day view","url":"http://www.example.com/","class":"event-warning","start":"1362938400000","end":"1363197686300"},{"id":"256","title":"Event that ends on timeline","url":"http://www.example.com/","class":"event-warning","start":"1363155300000","end":"1363227600000"},{"id":"276","title":"Short day event","url":"http://www.example.com/","class":"event-success","start":"1363245600000","end":"1363252200000"},{"id":"294","title":"This is information class ","url":"http://www.example.com/","class":"event-info","start":"1363111200000","end":"1363284086400"},{"id":"297","title":"This is success event","url":"http://www.example.com/","class":"event-success","start":"1363234500000","end":"1363284062400"},{"id":"54","title":"This is simple event","url":"http://www.example.com/","class":"","start":"1363712400000","end":"1363716086400"},{"id":"532","title":"This is inverse event","url":"http://www.example.com/","class":"event-inverse","start":"1364407200000","end":"1364493686400"},{"id":"548","title":"This is special event","url":"http://www.example.com/","class":"event-special","start":"1363197600000","end":"1363629686400"},{"id":"295","title":"Event 3","url":"http://www.example.com/","class":"event-important","start":"1364320800000","end":"1364407286400"}]}';
			}
		end

	end

	def show
		@service = Service.find(params[:id])
		@activities = PublicActivity::Activity.page(params[:page]).per(10).where(trackable_type: "Schedule", recipient_type: "Service", recipient_id: params[:id]).order("created_at desc")

		authorize @service

		respond_to do |format|
			format.js{

			}

			format.html{
			}

			format.json{
				render json: @service
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

		attachments_name_array = params[:service][:attachment_name] ||= []
		attachments_url_array = params[:service][:attachment_url] ||= []

		role_array.delete_if(&:empty?)
		people_array.delete_if(&:empty?)
		attachments_name_array.delete_if(&:empty?)
		attachments_url_array.delete_if(&:empty?)

		if !@service.valid?
			render "new"
		elsif !role_array.any? || !people_array.any?
			@service.errors.add(:schedules)
			render "new"
		elsif attachments_name_array.size != attachments_url_array.size
			@service.errors.add(:attachments)
			render "new"
		else
			# Service.find(params[:id]).schedules.destroy_all

			attachments_name_array.each_with_index do |attachment,index|
				Attachment.create(service:@service, name:attachment, url:attachments_url_array[index])
			end

			role_array.each_with_index do |role,index|
				person = Person.find(people_array[index])
				role = Role.find(role)

				schedule = Schedule.create(service:@service, role:role, person:person, created_by:current_person)
				ScheduleMailer.new_schedule_notification(schedule).deliver

			end

			@service.created_by = current_person
			@service.save(service_param)
			redirect_to services_path + "?date=" + @service.date.strftime("%F")
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
		attachments_name_array = params[:service][:attachment_name] ||= []
		attachments_url_array = params[:service][:attachment_url] ||= []

		role_array.delete_if(&:empty?)
		people_array.delete_if(&:empty?)
		confirmation_array.delete_if(&:empty?)
		attachments_name_array.delete_if(&:empty?)
		attachments_url_array.delete_if(&:empty?)

		if !@service.update(service_param)
			render "edit"
		elsif !role_array.any? || !people_array.any?
			@service.errors.add(:schedules)
			render "edit"
		else

			Attachment.where(service: @service).destroy_all
			attachments_name_array.each_with_index do |attachment,index|
				Attachment.create(service:@service, name:attachment, url:attachments_url_array[index])
			end


			# Remove all unconfirmed schedules from particular service because we're going to overide it
			# Schedule.where(service: @service, confirmed_at: nil).destroy_all
			#
			# role_array.each_with_index do |role,index|
			#
			# 	if confirmation_array[index] == "false"
			# 		person = Person.find(people_array[index])
			# 		role = Role.find(role_array[index])
			#
			# 		begin
			# 			schedule = Schedule.create(service:@service, role:role, person:person)
			# 			ScheduleMailer.new_schedule_notification(schedule).deliver
			# 		rescue ActiveRecord::RecordNotUnique => error
			# 			@service.errors.add(:schedules, " - You already assigned #{person.name} as #{role.name}. Operation canceled.")
			# 			render "edit"
			# 			return false
			# 		end
			# 	end
			#
			# end

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
