require 'test_helper'

describe Category do

  before do
    @category = Category.new
  end

  it { @category.must have_many(:participations).dependent(:destroy)}
  it { @category.must belong_to(:activity) }

  it { @category.must validate_presence_of(:distance) }

  it { @category.must validate_presence_of(:description) }

  it { @category.must validate_presence_of(:gender) }

  it { @category.must validate_presence_of(:age_from) }
  
  it { @category.must ensure_inclusion_of(:gender).in_array(['F', 'M']) }

  it 'should find matching category on base of gender, date_of_birth, activity and distance' do
    Time.any_instance.stubs(:to_date).returns(Date.new(2014,3,10))
    Category.find_matching(distance: 4, gender: 'F', activity_id: activities(:active), date_of_birth: Date.parse('10-03-2001')).must_equal categories(:six)
  end

  describe 'In case of a category with a start_time' do
    before do
      @category_one = categories(:one)
      @category_two = categories(:two)
    end

    it 'should add an error when category starttime is after the enddate of the activity' do
      @category_one.update_attribute(:start_time, "2014-04-27 10:00:00")
      @category_one.errors[:base].must_equal ['De starttijd moet binnen de start en einddatum van de activiteit liggen']
    end

    it 'should add an error when category starttime is before the startdate of the activity' do
      @category_two.update_attribute(:start_time, "2014-01-27 10:00:00")
      @category_two.errors[:base].must_equal ['De starttijd moet binnen de start en einddatum van de activiteit liggen']
    end

  end

end