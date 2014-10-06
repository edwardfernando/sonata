class ScheduleRejectedMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER_ADDRESS"]

  def notify(schedule)
    @schedule = schedule
    mail to: schedule.created_by.email, subject: "Schedule Rejected by : #{schedule.person.name} / #{schedule.service.name} - #{schedule.role.name}"
  end
end
