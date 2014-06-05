class RolesController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def index
    @roles = Role.all
    authorize @roles
  end

  def new
    @role = Role.new
    authorize @role
  end

  def create
    @role = Role.new(role_param)
    authorize @role

    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end

  end

  def edit
    @role = Role.find(params[:id])
    authorize @role
  end

  def update
    @role = Role.find(params[:id])
    authorize @role

    if @role.update(role_param)
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    authorize @role

    @role.destroy

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
