require 'test_helper'

class NewpostControllerTest < ActionController::TestCase
  def login_admin
    @user = users(:one)
    session[:user_id]=@user.id
  end

  def login_user
    @user = users(:two)
    session[:user_id]=@user.id
  end 

  test "anon should not create new topic" do
    post :index, :body => 'Post', title: 'title', part: Hash[1, 100]
    #post :create, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    #assert_response :success
    assert_redirected_to '/'
  end

  test "user should create new topic" do#!@#
  	#login_user
    #post :index, :body => 'Post', title: 'title', part: Hash[1, 100]
    #post :create, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    #assert_response :success
    #assert_redirected_to '/'
  end

end
