require 'test_helper'

class TypeRequestsControllerTest < ActionController::TestCase
  setup do
    @type_request = type_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_request" do
    assert_difference('TypeRequest.count') do
      post :create, type_request: { formato: @type_request.formato, nombre: @type_request.nombre }
    end

    assert_redirected_to type_request_path(assigns(:type_request))
  end

  test "should show type_request" do
    get :show, id: @type_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_request
    assert_response :success
  end

  test "should update type_request" do
    patch :update, id: @type_request, type_request: { formato: @type_request.formato, nombre: @type_request.nombre }
    assert_redirected_to type_request_path(assigns(:type_request))
  end

  test "should destroy type_request" do
    assert_difference('TypeRequest.count', -1) do
      delete :destroy, id: @type_request
    end

    assert_redirected_to type_requests_path
  end
end
