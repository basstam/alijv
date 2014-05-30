require 'test_helper'

describe Participant do

  before do
    Time.any_instance.stubs(:to_date).returns(Date.new(2014,3,10))
    @attributes = { firstname: 'Bas', lastname: 'Stam', street: 'Kronkelbaan', street_number: 32, zipcode: '1657LH',
                    city: 'Abbekerk', email: 'sebastiaan.stam@gmail.com', phone: '0625087982', date_of_birth: '1975-05-29',
                    gender: 'M', distance: 8}
    @participant = Participant.new
  end

  it { @participant.must have_many(:participations).dependent(:destroy)}

  it { @participant.must validate_presence_of(:lastname) }
  it { @participant.must validate_presence_of(:distance) }

  it { @participant.must ensure_inclusion_of(:gender).in_array(['F', 'M']) }

  it { @participant.wont allow_value('test@google').for(:email) }
  it { @participant.must allow_value('test@google.com').for(:email) }

  it { @participant.wont allow_value('1657').for(:zipcode) }
  it { @participant.must allow_value('1657LH').for(:zipcode) }
  it { @participant.must allow_value('1657 LH').for(:zipcode) }

  it { @participant.wont allow_value('06-49416406').for(:phone) }
  it { @participant.must allow_value('0649416406').for(:phone) }

  it { @participant.wont allow_value('8-6-64').for(:date_of_birth) }
  it { @participant.must allow_value('1964-6-8').for(:date_of_birth) }
  it { @participant.must allow_value('8-6-1964').for(:date_of_birth) }
  it { @participant.must allow_value('08-06-1964').for(:date_of_birth) }

  it 'should have the virtual attribute distance in its attributes' do
    @participant.attributes.keys.include?('distance').must_equal true
  end

  it 'should have the virtual attribute activity_id in its attributes' do
    @participant.attributes.keys.include?('activity_id').must_equal true
  end

  describe 'Participation' do

    before do
      activity     = activities(:active)
      @participant = Participant.create(@attributes.merge(activity_id: activity.id))
    end

    it 'should only create a participation if virtual attributes distance and activity_id are given' do
      Participation.count.must_equal 1
    end

    it 'should return the corresponding distance assuming there is only one active activity' do
      participant = Participant.find(@participant.id)
      participant.distance.must_equal 8
    end

  end

  describe 'In case no category found' do

    before do
      Category.destroy_all
      Participant.destroy_all
      @participant = Participant.create(@attributes.merge(activity_id: 1))
    end

    it 'should not create the participant' do
      Participant.count.must_equal 0
    end

    it 'should not create the participation of course' do
      Participation.count.must_equal 0
    end

    it 'should add an error' do
      @participant.errors[:base].must_equal ['Geen bijbehorende categorie gevonden!']
    end

  end

  describe 'Add participation' do

    before do
      Participation.destroy_all
      Participant.destroy_all
      @activity    = activities(:active)
    end

    describe 'with an existing participant' do

      before do
        @participant = Participant.create(@attributes.merge(email: 'info@stam.nl', activity_id: @activity.id))
      end

      it 'should not create the participant for the second time' do
        participant = Participant.new(@attributes.merge(lastname: 'stam', activity_id: @activity.id)).add_participation
        participant.id.must_equal @participant.id
        Participant.count.must_equal 1
      end

      it 'should not create a new participant but create a new participation in case of a new activity' do
        participant = Participant.new(@attributes.merge(lastname: 'stam', distance: 4, activity_id: 3)).add_participation
        participant.id.must_equal @participant.id
        Participation.count.must_equal 2
      end

     it 'should not create a new participant but edit the corresponding participation in case of the same activity (i.e. a different category)' do
        participant = Participant.new(@attributes.merge(lastname: 'stam', distance: 4, activity_id: @activity.id)).add_participation
        participant.id.must_equal @participant.id
        participant.email.must_equal 'info@stam.nl'
        @participant.participations.first.distance.must_equal 4
      end

    end

    describe 'with no existing participant' do

      before do
        @participant = Participant.new(@attributes.merge(activity_id: @activity.id)).add_participation
      end

      it 'should create the participant and participation' do
        assert @participant.id, 'Participant was not created!'
        Participant.count.must_equal 1
        Participation.count.must_equal 1
      end

    end

  end

  describe 'Uuid' do
    before do
      @participant = Participant.create(@attributes)
    end

    it 'should have an uniq identifier' do
      @participant.uuid.size.must_equal 40
    end

  end

end
