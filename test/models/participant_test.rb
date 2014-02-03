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

  it 'should have many matches' do
    match = Match.create(:name => 'Veldloop', :year => 2014, :distance => 8)
    participant = participants(:one)
    participant.matches << match
    participant.matches.must_equal [match]
  end

  #TODO? Category.new(:year => 2014, :gender => 'm', :distance =>4, :age => :junior).participants
end
