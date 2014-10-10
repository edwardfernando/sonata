namespace :reminder do

  task schedule: :environment do
    puts "### #{Time.now} : Executing upcoming schedule reminder"

    Schedule.joins(:service).where("is_confirmed = ? and services.date = ? and is_rejected = ?", 1, Date.today + 3, 0).each do |s|
      puts "  --- Send notification to #{s.person.email} / Schedule ID : #{s.id}"
      UpcomingScheduleMailer.notify(s).deliver
    end

    puts "### #{Time.now} : Finished upcoming schedule reminder"
  end

  task not_confirmed: :environment do
    puts "### #{Time.now} : Executing not_confirmed reminder"

    Schedule.joins(:service).where("is_confirmed = ? and services.date > ? and is_rejected = ?", 0, Date.today, 0).each do |s|
      puts "  --- Send notification to #{s.person.email} / Schedule ID : #{s.id}"
      NotConfirmedScheduleMailer.notify(s).deliver
    end

    puts "### #{Time.now} : Finished not_confirmed reminder"
  end

end
