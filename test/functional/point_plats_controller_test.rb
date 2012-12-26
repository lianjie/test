require 'test_helper'

class PointPlatsControllerTest < ActionController::TestCase
  setup do
    @point_plat = point_plats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:point_plats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create point_plat" do
    assert_difference('PointPlat.count') do
      post :create, point_plat: { lat: @point_plat.lat, lon: @point_plat.lon }
    end

    assert_redirected_to point_plat_path(assigns(:point_plat))
  end

  test "should show point_plat" do
    get :show, id: @point_plat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @point_plat
    assert_response :success
  end

  test "should update point_plat" do
    put :update, id: @point_plat, point_plat: { lat: @point_plat.lat, lon: @point_plat.lon }
    assert_redirected_to point_plat_path(assigns(:point_plat))
  end

  test "should destroy point_plat" do
    assert_difference('PointPlat.count', -1) do
      delete :destroy, id: @point_plat
    end

    assert_redirected_to point_plats_path
  end
end
