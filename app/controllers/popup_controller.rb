class PopupController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def popup_roles
    @roles = Role.all

    # Implemented inside role_policy
    authorize @roles
  end

  def popup_people
    @people = Person.joins(:skillsets).where("skillsets.role_id = ? and email is not null and is_approved = ?", params[:role], 1)

    # Implemented inside person_policy
    authorize @people
  end

end
