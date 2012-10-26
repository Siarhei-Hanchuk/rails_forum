require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def login_admin
    @user = users(:one)
    session[:user_id]=@user.id
  end

  def login_user
    @user = users(:two)
    session[:user_id]=@user.id
  end 

  setup do
    @comment = comments(:one)
  end

  test "user should create comment" do
    login_user
    assert_difference('Comment.count') do
      post :create, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "anon should not create comment" do
    assert_difference('Comment.count',0) do
      post :create, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    end

    assert_redirected_to '/'
  end

  test "admin should destroy comment" do
    login_admin
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to '/'
  end

  test "user should not destroy comment" do
    login_user
    assert_difference('Comment.count', 0) do
      delete :destroy, id: @comment
    end

    assert_redirected_to '/'
  end
end
