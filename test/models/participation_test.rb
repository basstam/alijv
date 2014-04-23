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

  describe 'In case of a update' do
    before do
      # in fixtures
      # start_date: "2014-03-27 10:00:00"
      # end_date: "2014-03-28 10:00:00"
      participant_one = participants(:one)
      @participation  = Participation.create(participant_id: participants(:one).id,
                                             category_id: categories(:two).id,
                                             activity_id: Activity.active.id )
    end

    it 'should raise a error when associate activity is closed' do
      @participation.update_attribute(:end_time, "2014-01-27 10:00:00")
      @participation.errors[:base].must_equal ['Deelname kan niet meer worden bijgewerkt, activiteit is afgesloten']
    end
    
  end


end
