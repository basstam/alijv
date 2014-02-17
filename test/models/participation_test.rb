require 'test_helper'

describe Participation do

  before do
     @participation = Participation.new
  end

  it { @participation.must belong_to(:activity) }
  it { @participation.must belong_to(:participant) }
  it { @participation.must belong_to(:category) }

  it { @participation.must validate_presence_of(:activity) }
  it { @participation.must validate_presence_of(:participant) }
  it { @participation.must validate_presence_of(:category) }

end
