class ProfilesController < ApplicationController

  before_filter :authenticate_person!

  def index
    render 'show'
  end

  def show
  end

  def edit
    @person = current_person
  end

  def update
    @person = Person.find(current_person)

    params[:person][:skillsets] ||= []

    if @person.update(person_param) && !params[:person][:skillsets].empty?
      Skillset.where(:person => @person).destroy_all

      for s in params[:person][:skillsets]
        Skillset.new(person:@person, role:Role.find(s)).save
      end

      redirect_to profile_path
    else
      @person.errors.add(:skillsets) if params[:person][:skillsets].empty?
      render "edit"
    end
  end

  def schedule
  end

  private
  def person_param
    params.require(:person).permit(:name, :email, :phone_number_1, :phone_number_2, :birthday, :skillsets)
  end
end
