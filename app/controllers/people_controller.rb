class PeopleController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def index
    @people = Person.all
    authorize @people
  end

  def profile
  end

  def approve
    @person = Person.find(params[:id])
    authorize @person

    unless @person.admin?
      @person.is_approved = 1
      @person.approved_date = DateTime.now
      @person.save(validate: false)

      PersonApprovedMailer.approved(@person).deliver
    end

    redirect_to people_path
  end

  def new
    @person = Person.new
    authorize @person
  end

  def create
    params[:person][:skillsets] ||= []

    @person = Person.new(person_param)
    authorize @person

    for s in params[:person][:skillsets]
      Skillset.new(person:@person, role:Role.find(s)).save
    end

    if @person.save
      redirect_to people_path
    else
      @person.errors.add(:skillsets) if params[:person][:skillsets].empty?
      render 'new'
    end

  end

  def edit
    @person = Person.find(params[:id])
    authorize @person
  end

  def update
    @person = Person.find(params[:id])
    authorize @person

    params[:person][:skillsets] ||= []

    if @person.update(person_param) && !params[:person][:skillsets].empty?
      Skillset.where(:person => @person).destroy_all

      for s in params[:person][:skillsets]
        Skillset.new(person:@person, role:Role.find(s)).save
      end

      redirect_to people_path
    else
      @person.errors.add(:skillsets) if params[:person][:skillsets].empty?
      render "edit"
    end

  end

  def show
    @person = Person.find(params[:id])
    authorize @person

    respond_to do |format|
      format.html{

      }

      format.json{
        render json: @person
      }
    end

  end

  def destroy
    @person = Person.find(params[:id])
    authorize @person

    @person.destroy
    redirect_to people_path
  end

  def find_by_role
    @skillsets = Role.find(params[:role]).skillsets
  end

  def update_level
    @person = Person.find(params[:id])
    authorize @person

    @person.update(role: params[:role_id])

    redirect_to people_path
  end

  private
  def person_param
    params.require(:person).permit(:name, :email, :phone_number_1, :phone_number_2, :birthday, :skillsets, :avatar_url, :avatar_url_cache)
  end

end
