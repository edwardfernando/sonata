class ProfilesController < ApplicationController

  before_filter :authenticate_person!

  def index

    respond_to do |format|

			format.html {
        render 'show'
			}

			format.json {
				start_date = Time.at(params[:from].to_i/1000).to_date
				end_date = Time.at(params[:to].to_i/1000).to_date

				@services = Service.joins(:schedules).where("date between ? and ? and schedules.person_id = ?", start_date, end_date, current_person)
				authorize @services
			}
		end
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

  def change_avatar
    @person = Person.find(current_person)
    @person.update(params.permit(:avatar_url, :avatar_url_cache))
    redirect_to profile_path
  end

  private
  def person_param
    params.require(:person).permit(:name, :email, :phone_number_1, :phone_number_2, :birthday, :skillsets, :avatar_url, :avatar_url_cache)
  end
end
