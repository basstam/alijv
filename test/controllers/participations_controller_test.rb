require 'test_helper'

describe ParticipationsController do

  before do
    participant_one = participants(:one)
    @participation  = Participation.create(participant_id: participants(:one).id,
                                           category_id: categories(:two).id,
                                           activity_id: Activity.active.id )

  end

  describe 'Startnumber' do
    before do
      sign_in_as_user
      put :update, id: @participation.id, participation: { startnumber: 12 }
    end

    it 'should update' do
      @participation.reload
      @participation.startnumber.must_equal 12
    end

  end

end
