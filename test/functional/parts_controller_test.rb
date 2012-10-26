require 'test_helper'

class PartsControllerTest < ActionController::TestCase
  #include Devise::TestHelpers

  def login_admin
    @user = users(:one)
    session[:user_id]=@user.id
  end

  def login_user
    @user = users(:two)
    session[:user_id]=@user.id
  end  

  setup do
    @part = parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parts)
  end

  test "should show part" do
    get :show, id: @part
    assert_response :success
  end

  test "admin should get new" do
    login_admin
    get :new
    assert_response :success
  end

  test "admin should create part" do
    login_admin
    assert_difference('Part.count') do
      post :create, part: { desc: @part.desc, title: @part.title}
    end

    assert_redirected_to part_path(assigns(:part))
  end

  test "admin should get edit" do
    login_admin
    get :edit, id: @part
    assert_response :success
  end

  test "admin should update part" do
    login_admin
    put :update, id: @part, part: { desc: @part.desc, title: @part.title }
    assert_redirected_to part_path(assigns(:part))
  end

  test "admin should destroy part" do
    login_admin
    assert_difference('Part.count', -1) do
      delete :destroy, id: @part
    end

    assert_redirected_to parts_path
  end

  test "user should not update part" do
    login_user
    put :update, id: @part, part: { desc: @part.desc, title: @part.title }
    assert_redirected_to '/'
  end

  test "user should not get new" do
    login_user
    get :new
    assert_redirected_to '/'
  end
  
  test "user should not create part" do
    login_user
    assert_difference('Part.count',0) do
      post :create, part: { desc: @part.desc, title: @part.title}
    end

    assert_redirected_to '/'
  end

  test "user should not get edit" do
    login_user
    get :edit, id: @part
    assert_redirected_to '/'
  end

  test "user should not destroy part" do
    login_user
    assert_difference('Part.count', 0) do
      delete :destroy, id: @part
    end

    assert_redirected_to '/'
  end

   test "anon should not update part" do
    put :update, id: @part, part: { desc: @part.desc, title: @part.title }
    assert_redirected_to '/'
  end

  test "anon should not get new" do
    get :new
    assert_redirected_to '/'
  end
  
  test "anon should not create part" do
    assert_difference('Part.count',0) do
      post :create, part: { desc: @part.desc, title: @part.title}
    end

    assert_redirected_to '/'
  end

  test "anon should not get edit" do
    get :edit, id: @part
    assert_redirected_to '/'
  end

  test "anon should not destroy part" do
    assert_difference('Part.count', 0) do
      delete :destroy, id: @part
    end

    assert_redirected_to '/'
  end
end
