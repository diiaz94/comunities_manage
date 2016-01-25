require 'test_helper'

class ParishesControllerTest < ActionController::TestCase
  setup do
    @parish = parishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parish" do
    assert_difference('Parish.count') do
      post :create, parish: { nombre: @parish.nombre }
    end

    assert_redirected_to parish_path(assigns(:parish))
  end

  test "should show parish" do
    get :show, id: @parish
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parish
    assert_response :success
  end

  test "should update parish" do
    patch :update, id: @parish, parish: { nombre: @parish.nombre }
    assert_redirected_to parish_path(assigns(:parish))
  end

  test "should destroy parish" do
    assert_difference('Parish.count', -1) do
      delete :destroy, id: @parish
    end

    assert_redirected_to parishes_path
  end
end
