require 'test_helper'

describe Participant do

  it 'should validate presence of lastname' do
    participant = Participant.create(:firstname => 'Frank')
    participant.errors[:lastname].must_equal ["moet opgegeven zijn"]
  end

end
