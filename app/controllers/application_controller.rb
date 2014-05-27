class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery

  protected
	def is_logged_in
		if !user_signed_in?
			flash[:warning] = "Please sign in first."
			redirect_to login_path
		end
	end
end
