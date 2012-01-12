require 'test_helper'

class BonusRoundsControllerTest < ActionController::TestCase
  setup do
    @bonus_round = bonus_rounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bonus_rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bonus_round" do
    assert_difference('BonusRound.count') do
      post :create, :bonus_round => @bonus_round.attributes
    end

    assert_redirected_to bonus_round_path(assigns(:bonus_round))
  end

  test "should show bonus_round" do
    get :show, :id => @bonus_round.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bonus_round.to_param
    assert_response :success
  end

  test "should update bonus_round" do
    put :update, :id => @bonus_round.to_param, :bonus_round => @bonus_round.attributes
    assert_redirected_to bonus_round_path(assigns(:bonus_round))
  end

  test "should destroy bonus_round" do
    assert_difference('BonusRound.count', -1) do
      delete :destroy, :id => @bonus_round.to_param
    end

    assert_redirected_to bonus_rounds_path
  end
end
