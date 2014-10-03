class UpcomingScheduleMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER_ADDRESS"]

  def notify(schedule)
    @schedule = schedule
    mail to: schedule.person.email, subject: "Your upcoming schedule : #{schedule.service.name} - #{schedule.role.name}"
  end
end
