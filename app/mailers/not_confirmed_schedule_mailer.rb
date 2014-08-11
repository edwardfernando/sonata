class NotConfirmedScheduleMailer < ActionMailer::Base
  default from: "sonata@sonata.com"

  def notify(schedule)
    @schedule = schedule
    mail to: schedule.person.email, subject: "Sonata - Action Required for : #{schedule.service.name} - #{schedule.role.name}"
  end

end
