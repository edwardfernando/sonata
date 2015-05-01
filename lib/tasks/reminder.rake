namespace :reminder do

  task schedule: :environment do
    puts "### #{Time.now} : Executing upcoming schedule reminder\n"

    Schedule.joins(:service).where("status = ? and services.date between ? and ?", 1, Date.today, Date.today + 3).each do |s|
      puts "  --- Send notification to #{s.person.email} / Schedule ID : #{s.id}\n"
      UpcomingScheduleMailer.notify(s).deliver
    end

    puts "### #{Time.now} : Finished upcoming schedule reminder\n"
  end

  task not_confirmed: :environment do
    puts "### #{Time.now} : Executing not_confirmed reminder\n"

    Schedule.joins(:service).where("status = ? and services.date > ?", 0, Date.today).each do |s|
      puts "  --- Send notification to #{s.person.email} / Schedule ID : #{s.id}\n"
      NotConfirmedScheduleMailer.notify(s).deliver
    end

    puts "### #{Time.now} : Finished not_confirmed reminder\n"
  end

  task remind_invitation: :environment do

    puts "### #{Time.now} : Executing invitation reminder\n"

    Person.where.not(invitation_token: nil).each do |person|
      AccountRegistrationMailer.remind(person).deliver
    end

    puts "### #{Time.now} : Finished invitation reminder\n"

  end

end
