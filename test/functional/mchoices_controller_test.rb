require 'test_helper'

class MchoicesControllerTest < ActionController::TestCase
  setup do
    @mchoice = mchoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mchoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mchoice" do
    assert_difference('Mchoice.count') do
      post :create, :mchoice => @mchoice.attributes
    end

    assert_redirected_to mchoice_path(assigns(:mchoice))
  end

  test "should show mchoice" do
    get :show, :id => @mchoice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mchoice.to_param
    assert_response :success
  end

  test "should update mchoice" do
    put :update, :id => @mchoice.to_param, :mchoice => @mchoice.attributes
    assert_redirected_to mchoice_path(assigns(:mchoice))
  end

  test "should destroy mchoice" do
    assert_difference('Mchoice.count', -1) do
      delete :destroy, :id => @mchoice.to_param
    end

    assert_redirected_to mchoices_path
  end
end
