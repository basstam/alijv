require 'test_helper'

describe Participation do

  before do
     @participant = participants(:one)
     @activity    = activities(:one)
     @category    = categories(:one)
     @participation = Participation.create( :activity_id => @activity.id, :category_id => @category.id, :participant_id => @participant.id)

  end

  it 'should be valid' do
    assert @participation
  end

  it 'should belong to one participant' do
    @participation.participant.must_equal @participant
  end

  it 'should belong to one category' do
    @participation.category.must_equal @category
  end

  it 'should belong to one activity' do
    @participation.activity.must_equal @activity
  end

end
