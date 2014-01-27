require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  setup do
    @participant = participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participant" do
    assert_difference('Participant.count') do
      post :create, participant: { address: @participant.address, city: @participant.city, date_of_birth: @participant.date_of_birth, email: @participant.email, firstname: @participant.firstname, gender: @participant.gender, lastname: @participant.lastname, phone: @participant.phone, zipcode: @participant.zipcode }
    end

    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should show participant" do
    get :show, id: @participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participant
    assert_response :success
  end

  test "should update participant" do
    patch :update, id: @participant, participant: { address: @participant.address, city: @participant.city, date_of_birth: @participant.date_of_birth, email: @participant.email, firstname: @participant.firstname, gender: @participant.gender, lastname: @participant.lastname, phone: @participant.phone, zipcode: @participant.zipcode }
    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should destroy participant" do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end

    assert_redirected_to participants_path
  end
end
