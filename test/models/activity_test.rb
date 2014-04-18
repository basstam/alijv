require 'test_helper'

describe Activity do
  
  before do
    @activity = Activity.new
  end

  it { @activity.must have_many(:categories).dependent(:destroy)}

  it { @activity.must validate_presence_of(:name) }

  it { @activity.must validate_presence_of(:start_date) }

  describe 'In case of one or more categories belonging to activity' do
    before do
      @category_one = categories(:one)
      @category_one.update_attribute(:start_time, "2014-04-27 10:00:00")

      @activity_active = activities(:active)
      @activity_active.update_attribute(:end_date, "2014-04-26 10:00:00")
    end

    it 'should add an error when category starttime is not between start and enddate of the activity' do
      @activity_active.errors[:base].must_equal ['De starttijd(en) van de bijbehorende categorie(en) moet(en) binnen de start en einddatum van de activiteit liggen']
    end
  end

  describe 'Validate start_date before end_date' do
    before do
      @activity = Activity.create(name: "veldloop a", description: "velloop a", start_date: "2014-03-27", end_date: "2014-03-26")
    end
      
    it 'should add an error' do
      @activity.errors[:start_date].must_equal ['moet kleiner of gelijk zijn dan de einddatum']
    end

    it 'should not save the record' do
      Activity.count.must_equal 3 #Number of records in fixtures
    end
  end

  describe 'in case of more then one active activity' do
    before do
      @second_active_activity = Activity.create(name: "veldloop a", description: "velloop a", start_date: "2014-03-27 10:00:00", active: true)
    end
      
    it 'should add an error' do
      @second_active_activity.errors[:base].must_equal ['Er mag maximaal 1 activiteit actief zijn.']
    end
  end
end