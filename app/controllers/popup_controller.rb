class PopupController < ApplicationController

  def popup_roles
    @roles = Role.all
  end

  def popup_people
    @people = Person.joins(:skillsets).where("skillsets.role_id = #{params[:role]}")
  end

end
