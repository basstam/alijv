require 'test_helper'

describe ParticipantsController do
  
  before do
    @participant = participants(:one)
  end

  it 'should get index' do
    get :index 
    assert_response :success
  end

  it 'should get new' do
    get :new
    assert_response :success
  end

  describe 'create' do
    
    before do
      @mail = ActionMailer::Base.deliveries.last
    end

    it 'should create participant' do
      assert_difference('Participant.count') do
        post :create, participant: { street: @participant.street, street_number: @participant.street_number, city: @participant.city, 
                                     date_of_birth: @participant.date_of_birth, email: @participant.email, firstname: @participant.firstname + '2', 
                                     gender: @participant.gender, lastname: @participant.lastname, phone: @participant.phone, zipcode: @participant.zipcode,
                                     distance: 2 }
      end
      assert_redirected_to participant_path(assigns(:participant))
    end

    it 'should sent a confimation mail' do
      assert @mail, 'No mail sent'
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

  test 'should destroy participant' do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end
    assert_redirected_to participants_path
  end
end
