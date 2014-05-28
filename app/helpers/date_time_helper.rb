module DateTimeHelper
  def today
    DateTime.now.strftime("%F")
  end

  def get_valid_date time
    time.blank? ? DateTime.now.strftime("%F") : time
  end
end
