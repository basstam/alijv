require 'test_helper'

describe ParticipantsController do

  before do
    @participant = participants(:one)
    @participant_attributes = { street: @participant.street, street_number: @participant.street_number, city: @participant.city,
                                date_of_birth: @participant.date_of_birth, email: @participant.email, firstname: @participant.firstname + '2',
                                gender: @participant.gender, lastname: @participant.lastname, phone: @participant.phone, zipcode: @participant.zipcode,
                                distance: 2 }
    sign_in_as_user
  end

  it 'should get index' do
    get :index
    assert_response :success
  end

  it 'should get new' do
    get :new
    assert_response :success
  end

  it 'should get show' do
    get :show, id: @participant.id
    assert_response :success
  end

  it 'should get confirmation' do
    get :confirmation, id: @participant.id
    assert_response :success
  end

  describe 'create as visitor' do

    before  do
      ActionMailer::Base.deliveries.clear
      sign_out_as_user
      post :create, participant: @participant_attributes
    end

    it 'should create participant' do
      Participant.last.date_of_birth.must_equal @participant.date_of_birth
    end

    it 'should show confirmation form' do
      assert_template 'confirmation'
    end

    it 'should sent a confimation mail' do
      mail = ActionMailer::Base.deliveries.last
      mail.to.first.must_equal @participant.email
    end

  end

  describe 'create as admin' do

    before do
      ActionMailer::Base.deliveries.clear
      post :create, participant: @participant_attributes
    end

    it 'should NOT sent a confimation mail' do
      mail = ActionMailer::Base.deliveries.last
      mail.must_equal nil
    end

    it 'should redirect to overview' do
      assert_redirected_to participant_path(assigns(:participant))
    end

  end

  it 'should show participant' do
    get :show, id: @participant
    assert_response :success
  end

  it 'should get edit' do
    get :edit, id: @participant
    assert_response :success
  end

  it 'should update participant' do
    patch :update, id: @participant, participant: { street: @participant.street, city: @participant.city, date_of_birth: @participant.date_of_birth,
                                                    email: @participant.email, firstname: @participant.firstname, gender: @participant.gender,
                                                    lastname: @participant.lastname, phone: @participant.phone, zipcode: @participant.zipcode,
                                                    distance: 2 }
    assert_redirected_to participant_path(assigns(:participant))
  end

  it 'should destroy participant' do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end
    assert_redirected_to participants_path
  end
end
