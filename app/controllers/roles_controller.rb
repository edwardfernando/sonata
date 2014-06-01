class RolesController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def index
    @roles = Role.all
    authorize @roles
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_param).save
    redirect_to roles_path
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    @role.update(role_param)
    redirect_to services_path
  end

  def destroy
    Role.find(params[:id]).destroy
    redirect_to roles_path
  end

  def show
    @role = Role.find(params[:id])
  end

  private
  def role_param
    params.require(:role).permit(:name)
  end
end
