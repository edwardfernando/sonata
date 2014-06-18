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

end
