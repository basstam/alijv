require "test_helper"

describe 'confirmation mail' do

  before do
    @participant = Participant.create! firstname: 'Bas', lastname: 'Stam', street: 'Kronkelbaan', street_number: 32,
                                       zipcode: '1657LH', city: 'Abbekerk', email: 'sebastiaan.stam@gmail.com', phone: '0625087982',
                                       date_of_birth: '1975-05-29', gender: 'M', distance: 8
    @mail       = ParticipantMailer.confirmation(@participant)

  end

  it 'should sent from the administrator' do
    @mail.from.first.must_equal 'veldloop@ijsclubalijv.nl'
  end

  it 'should sent to email of the participant' do
    @mail.to.first.must_equal @participant.email
  end

  it 'should addres the firstname of the participant' do
    assert_match /^Beste Bas,/, @mail.body.raw_source
  end
  
end