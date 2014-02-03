require 'test_helper'

describe Match do

  before do
    @participant = participants(:one)
    @match = Match.create(:name => 'Veldloop', :year => 2014, :distance => 8, :participant_id => @participant.id)
  end

  it 'should be valid' do
    assert @match
  end

  it 'should belong to one participant' do
    @match.participant.must_equal @participant
  end

end
