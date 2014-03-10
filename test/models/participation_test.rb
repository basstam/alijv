require 'test_helper'

describe Participation do

  before do
     @participation = Participation.new
  end

  it { @participation.must belong_to(:activity) }
  it { @participation.must belong_to(:participant) }
  it { @participation.must belong_to(:category) }

  it { @participation.must validate_presence_of(:activity_id) }
  it { @participation.must validate_presence_of(:participant_id) }
  it { @participation.must validate_presence_of(:category_id) }

end
