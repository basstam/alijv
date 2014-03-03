require 'test_helper'

describe Activity do
  
  before do
    @activity = Activity.new
  end

  it { @activity.must have_many(:categories).dependent(:destroy)}

  it { @activity.must validate_presence_of(:name) }

  it 'should return all active activities' do
    Activity.all_active.count.must_equal 1
    Activity.all_active.first.name.must_equal 'Veldloop 2015'
  end

end