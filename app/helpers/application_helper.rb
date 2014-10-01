module ApplicationHelper

  def get_unconfirmed_schedules
    counter = 0
    current_person.schedules.each do |schedule|
      if schedule.confirmed_at.nil?
        counter = counter + 1
      end
    end
    return counter
  end


 # Display a custom sign_in form anywhere in your app
  # https://github.com/plataformatec/devise/wiki/How-To:-Display-a-custom-sign_in-form-anywhere-in-your-app
  # def resource_name
  #   :people
  # end
 
  # def resource
  #   @resource ||= Person.new
  # end
 
  # def devise_mapping
  #   @devise_mapping ||= Devise.mappings[:people]
  # end

end
