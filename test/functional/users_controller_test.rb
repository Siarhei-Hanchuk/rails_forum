require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTP_REFERER'] = 'http://test.host/'
    @user = users(:one)
  end

  test "admin should get index" do
  	login_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "user should not get index" do
  	login_user
    get :index
    assert_redirected_to '/'
  end

  test "anon should not get index" do
    get :index
    assert_redirected_to '/'
  end

#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create user" do
#    assert_difference('User.count') do
#      post :create, user: { nickname: @user.nickname, provider: @user.provider, url: @user.url, username: @user.username }
#    end
#
#    assert_redirected_to user_path(assigns(:user))
#  end
#

 # test "user should show user" do
  ##	login_user
   # get :show, id: @user
    #assert_response :success
  #end

  test "anon should not show user" do
    get :show, id: @user
    assert_redirected_to '/'
  end

  test "admin should get edit any" do
  	login_admin
    get :edit, id: @user
    assert_response :success
  end

  #test "user should not get edit any" do
  #	@user.id=login_user+1
  #  get :edit, id: @user
  #  assert_redirected_to '/'
  #end

  test "user should get edit own" do
  	@user.id=login_user
    get :edit, id: @user
    assert_response :success
  end

  test "anon should not get edit" do
    get :edit, id: @user
    assert_redirected_to '/'
  end

#  test "should update user" do
#    put :update, id: @user, user: { nickname: @user.nickname, provider: @user.provider, url: @user.url, username: @user.username }
#    assert_redirected_to user_path(assigns(:user))
#  end
#
#  test "should destroy user" do
#    assert_difference('User.count', -1) do
#      delete :destroy, id: @user
#    end
#
#    assert_redirected_to users_path
#  end
end
