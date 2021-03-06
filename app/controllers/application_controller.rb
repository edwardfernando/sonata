class ApplicationController < ActionController::Base

  include PublicActivity::StoreController
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  # http://excid3.com/blog/change-actionmailer-email-url-host-dynamically/
  before_filter :set_mailer_host
  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  # Need to add this method - since pundit expects it
  def pundit_user
    current_person
  end

  protected
	def is_logged_in
		if !person_signed_in?
			flash[:warning] = "Please sign in first."
			redirect_to login_path
		end
	end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name

    # Invitable
    devise_parameter_sanitizer.for(:accept_invitation).concat [:name]
  end

  rescue_from Pundit::NotAuthorizedError, with: :person_not_authorized

  private
  def person_not_authorized
    flash[:notice] = "Access denied."
    redirect_to denied_path
    # redirect_to (request.referrer || root_path)
  end
end
