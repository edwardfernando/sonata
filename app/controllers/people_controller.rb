class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    params[:person][:skillsets] ||= []

    @person = Person.new(person_param)
    @person.save

    for s in params[:person][:skillsets]
      Skillset.new(person:@person, role:Role.find(s)).save
    end

    redirect_to people_path
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    params[:person][:skillsets] ||= []

    @person = Person.find(params[:id])
    @person.update(person_param)

    Skillset.where(:person => @person).destroy_all

    for s in params[:person][:skillsets]
      Skillset.new(person:@person, role:Role.find(s)).save
    end

    redirect_to services_path
  end

  def show
    @person = Person.find(params[:id])
  end

  def destroy
    Person.find(params[:id]).destroy
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
