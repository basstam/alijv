class ParticipantMailer < ActionMailer::Base
  default from: 'veldloop@ijsclubalijv.nl'

  def confirmation(participant)
    @participant = participant
    mail to:       participant.email,
         content_type: 'text/plain',
         subject:  'Bevestiging deelname'
  end
end
