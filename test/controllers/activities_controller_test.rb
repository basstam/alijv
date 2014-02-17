require "test_helper"

describe ActivitiesController do

  before do
    @activity = activities(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create activity" do
    assert_difference('Activity.count') do
      post :create, activity: { name: 'Veldloop', description: 'De loop van het jaar' }
    end

    assert_redirected_to activity_path(assigns(:activity))
  end

  it "must show activity" do
    get :show, id: @activity
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @activity
    assert_response :success
  end

  it "must update activity" do
    put :update, id: @activity, activity: {description: 'De veldloop van het jaar!' }
    assert_redirected_to activity_path(assigns(:activity))
  end

  it "must destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_redirected_to activities_path
  end

end
