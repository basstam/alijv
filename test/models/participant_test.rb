require 'test_helper'

describe Participant do

  it 'should validate presence of lastname' do
    participant = Participant.create(:firstname => 'Frank')
    participant.errors[:lastname].must_equal ["moet opgegeven zijn"]
  end

  it 'should validate format of email' do
    participant = participants(:one)
    participant.email="test@google"
    participant.save.must_equal false
  end

end
