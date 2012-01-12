require 'test_helper'

class GameLevelsControllerTest < ActionController::TestCase
  setup do
    @game_level = game_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_level" do
    assert_difference('GameLevel.count') do
      post :create, :game_level => @game_level.attributes
    end

    assert_redirected_to game_level_path(assigns(:game_level))
  end

  test "should show game_level" do
    get :show, :id => @game_level.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game_level.to_param
    assert_response :success
  end

  test "should update game_level" do
    put :update, :id => @game_level.to_param, :game_level => @game_level.attributes
    assert_redirected_to game_level_path(assigns(:game_level))
  end

  test "should destroy game_level" do
    assert_difference('GameLevel.count', -1) do
      delete :destroy, :id => @game_level.to_param
    end

    assert_redirected_to game_levels_path
  end
end
