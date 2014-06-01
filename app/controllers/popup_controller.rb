class PopupController < ApplicationController

  before_filter :authenticate_person!
#  after_action :verify_authorized

  def popup_roles
    @roles = Role.all
  end

  def popup_people
    @people = Person.joins(:skillsets).where("skillsets.role_id = #{params[:role]}")
  end

end
