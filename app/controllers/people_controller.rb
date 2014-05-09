class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_param).save
    redirect_to people_path
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    @person.update(person_param)
    redirect_to person_path(@person)
  end

  private
  def person_param
    params.require(:person).permit(:name)
  end

end
