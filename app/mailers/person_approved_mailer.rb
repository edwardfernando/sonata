class PersonApprovedMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER_ADDRESS"]

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.person_approved_mailer.approved.subject
  #
  def approved(person)
    @person = person
    mail to: person.email, subject: "Your Account Approved!"
  end
end
