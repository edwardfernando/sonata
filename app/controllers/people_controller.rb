class PeopleController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def index
    @people = Person.all
    authorize @people
  end

  def profile
  end

  def new
    @person = Person.new
    authorize @person
  end

  def create
    params[:person][:skillsets] ||= []

    @person = Person.new(person_param)
    authorize @person

    @person.save

    for s in params[:person][:skillsets]
      Skillset.new(person:@person, role:Role.find(s)).save
    end

    redirect_to people_path
  end

  def edit
    @person = Person.find(params[:id])
    authorize @person
  end

  def update
    params[:person][:skillsets] ||= []

    @person = Person.find(params[:id])
    authorize @person

    @person.update(person_param)

    Skillset.where(:person => @person).destroy_all

    for s in params[:person][:skillsets]
      Skillset.new(person:@person, role:Role.find(s)).save
    end

    redirect_to people_path
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
    params.require(:person).permit(:name, :skillsets)
  end

end
