# Preview all emails at http://localhost:3000/rails/mailers/schedule_mailer
class ScheduleMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/schedule_mailer/new_schedule_notification
  def new_schedule_notification
    ScheduleMailer.new_schedule_notification
  end

end
