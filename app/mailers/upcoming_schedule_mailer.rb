class UpcomingScheduleMailer < ActionMailer::Base
  default from: "sonata@sonata.com"

  def notify(schedule)
    @schedule = schedule
    mail to: schedule.person.email, subject: "Sonata - Your upcoming schedule : #{schedule.service.name} - #{schedule.role.name}"
  end
end
