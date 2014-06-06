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

    if @person.valid?
      @person.update(is_approved: true, approved_date: DateTime.now)
      redirect_to people_path
    else
      render 'edit'
    end

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

  private
  def person_param
    params.require(:person).permit(:name, :email, :skillsets)
  end

end
