class ParticipantMailer < ActionMailer::Base
  default from: 'veldloop@ijsclubalijv.nl'

  def confirmation(participant)
    @participant = participant
    mail to:            participant.email,
         bcc:          'sebastiaan.stam@gmail.com',
         content_type: 'text/plain',
         subject:      'Bevestiging deelname'
  end
end
