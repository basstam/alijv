require 'test_helper'

describe Participant do

  before do
    @participant = Participant.new
  end

  it { @participant.must have_many(:participations).dependent(:destroy)}

  it { @participant.must validate_presence_of(:lastname) }

  it { @participant.must ensure_inclusion_of(:gender).in_array(['V', 'M']) }

  it { @participant.wont allow_value('test@google').for(:email) }
  it { @participant.must allow_value('test@google.com').for(:email) }

  it { @participant.wont allow_value('1657').for(:zipcode) }
  it { @participant.must allow_value('1657LH').for(:zipcode) }

  it { @participant.wont allow_value('06-49416406').for(:phone) }
  it { @participant.must allow_value('0649416406').for(:phone) }

  it { @participant.wont allow_value('8-6-64').for(:date_of_birth) }
  it { @participant.must allow_value('1964-6-8').for(:date_of_birth) }
  it { @participant.must allow_value('8-6-1964').for(:date_of_birth) }
  it { @participant.must allow_value('08-06-1964').for(:date_of_birth) }

end
