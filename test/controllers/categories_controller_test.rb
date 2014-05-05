require "test_helper"

describe CategoriesController do

  before do
    @category = categories(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  it "must get find_matching" do
    get :find_matching, :format => :json
    assert_response :success
    assert_equal "{\"result\":\"not found\"}", response.body
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create category" do
    assert_difference('Category.count') do
      post :create, category: {  description: 'Mannen Senior 4Km', activity_id: 1, distance: 4.0, age_from: 18, gender: 'M'}
    end

    assert_redirected_to category_path(assigns(:category))
  end

  it "must show category" do
    get :show, id: @category
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @category
    assert_response :success
  end

  it "must update category" do
    put :update, id: @category, category: { age_from: 19  }
    assert_redirected_to category_path(assigns(:category))
  end

  it "must destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end

end
