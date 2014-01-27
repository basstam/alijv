require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  test 'validate presence of lastname' do
    participant = Participant.create(:firstname => 'Frank')
    assert_equal ["can't be blank"], participant.errors[:lastname]
  end
end
