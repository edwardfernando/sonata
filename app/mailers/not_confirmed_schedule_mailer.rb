class NotConfirmedScheduleMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER_ADDRESS"]

  def notify(schedule)
    @schedule = schedule
    mail to: schedule.person.email, subject: "Action required : #{schedule.service.name} - #{schedule.role.name}"
  end

end
