require 'test_helper'

describe Participant do
  
  it 'should have a lastname' do
    participant = Participant.create(:firstname => 'Frank')
    participant.errors[:lastname].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a firstname' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:firstname].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a street' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:street].must_equal ["moet opgegeven zijn"]
  end

  # it 'should have a zipcode' do
  #   participant = Participant.create(:lastname => 'Stam')
  #   participant.errors[:zipcode].must_equal ["moet opgegeven zijn"]
  # end

  it 'should have a street_number' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:street_number].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a city' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:city].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a phone' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:phone].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a date_of_birth' do
    participant = Participant.create(:lastname => 'Stam')
    participant.errors[:date_of_birth].must_equal ["moet opgegeven zijn"]
  end
  
  # it 'should have a correct zipcode' do
  #   participant = participants(:one)
  #   participant.zipcode = '1657'
  #   participant.save.must_equal false
  # end

  # it 'should have a gender' do
  #   participant = participants(:one)
  #   participant.gender = 'X'
  #   participant.save.must_equal false
  # end

  ## TODO datae_of_birth format validation? 

  # it 'should validate format of email' do
  #   participant = participants(:one)
  #   participant.email="test@google"
  #   participant.save.must_equal false
  # end


end
