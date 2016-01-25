require 'test_helper'

class ComunitiesControllerTest < ActionController::TestCase
  setup do
    @comunity = comunities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comunities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comunity" do
    assert_difference('Comunity.count') do
      post :create, comunity: { direccion: @comunity.direccion, nombre: @comunity.nombre, slug: @comunity.slug }
    end

    assert_redirected_to comunity_path(assigns(:comunity))
  end

  test "should show comunity" do
    get :show, id: @comunity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comunity
    assert_response :success
  end

  test "should update comunity" do
    patch :update, id: @comunity, comunity: { direccion: @comunity.direccion, nombre: @comunity.nombre, slug: @comunity.slug }
    assert_redirected_to comunity_path(assigns(:comunity))
  end

  test "should destroy comunity" do
    assert_difference('Comunity.count', -1) do
      delete :destroy, id: @comunity
    end

    assert_redirected_to comunities_path
  end
end
