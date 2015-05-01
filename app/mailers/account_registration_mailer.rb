class AccountRegistrationMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER_ADDRESS"]

  def remind(person)

    invited_person = Person.invite!({:email => person.email}, person.invited_by) do |invitee|
      invitee.skip_invitation = true
    end

    @person = invited_person

    mail to: person.email, subject: "Complete your profile! #{invited_person.invited_by.name} invited to Sonatask.com - GII Semanggi Jakarta"
  end

end
