require 'test_helper'

class UzersControllerTest < ActionController::TestCase
  setup do
    @uzer = uzers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uzers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uzer" do
    assert_difference('Uzer.count') do
      post :create, uzer: { nickname: @uzer.nickname, provider: @uzer.provider, url: @uzer.url, username: @uzer.username }
    end

    assert_redirected_to uzer_path(assigns(:uzer))
  end

  test "should show uzer" do
    get :show, id: @uzer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uzer
    assert_response :success
  end

  test "should update uzer" do
    put :update, id: @uzer, uzer: { nickname: @uzer.nickname, provider: @uzer.provider, url: @uzer.url, username: @uzer.username }
    assert_redirected_to uzer_path(assigns(:uzer))
  end

  test "should destroy uzer" do
    assert_difference('Uzer.count', -1) do
      delete :destroy, id: @uzer
    end

    assert_redirected_to uzers_path
  end
end
