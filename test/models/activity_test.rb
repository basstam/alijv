require 'test_helper'

describe Activity do
  
  before do
    @activity = Activity.new
  end

  it { @activity.must have_many(:categories).dependent(:destroy)}

  it { @activity.must validate_presence_of(:name) }

  it { @activity.must validate_presence_of(:start_date) }
  
  describe 'in case of more then one active activity' do
    before do
      Activity.destroy_all
      Activity.create(name: "veldloop a", description: "velloop a", start_date: "2014-03-27 10:00:00", active: true)
      Activity.create(name: "veldloop b", description: "velloop b", start_date: "2014-02-27 10:00:00", active: true)
      #Activity.where(id: 1).update_all(active: true)
    end
      
    it 'should add an error' do
      @activity.errors[:base].must_equal ['Er mag maximaal 1 activiteit actief zijn.']
    end
  end
end