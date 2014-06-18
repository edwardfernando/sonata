# Preview all emails at http://localhost:3000/rails/mailers/person_approved_mailer
class PersonApprovedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/person_approved_mailer/approved
  def approved
    PersonApprovedMailer.approved
  end

end
