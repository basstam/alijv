require 'test_helper'

describe Activity do
  
  before do
    @activity = Activity.new
  end

  it { @activity.must have_many(:categories).dependent(:destroy)}

  it { @activity.must validate_presence_of(:name) }

  it 'should return the active activity' do
    Activity.active.name.must_equal 'Veldloop 2015'
  end

end