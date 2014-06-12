class ScheduleMailer < ActionMailer::Base
  default from: "schedule@sonata.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.schedule_mailer.new_schedule_notification.subject
  #
  def new_schedule_notification(schedule)
    @schedule = schedule
    mail to: schedule.person.email, subject: "Sonata - New Schedule for : #{schedule.role.name}"
  end
end
