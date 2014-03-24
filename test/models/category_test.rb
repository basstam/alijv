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

end