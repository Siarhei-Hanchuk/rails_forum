require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def login_admin
    @user = users(:one)
    session[:user_id]=@user.id
  end

  def login_user
    @user = users(:two)
    session[:user_id]=@user.id
  end  

  setup do
  	@topic=Topic.create(title: 'topic', part_id: 10, user_id: 1)
    @post = posts(:one)
    @post.topic_id=@topic.id
  end

  test "user should create post" do
  	@post.user_id=login_user
    assert_difference('Post.count') do
      post :create, post: { body: @post.body, topic_id: @post.topic_id, user_id: @post.user_id }
    end

    assert_redirected_to '/topics/'+@topic.id.to_s+'?page=1#'+(@post.id+1).to_s
  end

  test "anon should not create post" do
    assert_difference('Post.count',0) do
      post :create, post: { body: @post.body, topic_id: @post.topic_id, user_id: @post.user_id }
    end

    assert_redirected_to '/'
  end

  test "admin should get edit any post" do
  	login_admin
    get :edit, id: @post
    assert_response :success
  end

#  test "user should get edit own post" do
#  	user_id=login_user
#  	@post.user_id=user_id
#    get :edit, id: @post.id
#    assert_response :success
#    #assert_redirected_to '/posts/'+@post.id.to_s+'/edit'
#    #assert_redirected_to '/posts/'+@post.user_id.to_s+'/edit'+user_id.to_s
#  end

  test "user should not get edit alien post" do
    @post.user_id=login_user+1
    get :edit, id: @post
    assert_redirected_to '/'
  end

  test "anon should not get edit" do
    get :edit, id: @post
    assert_redirected_to '/'
  end

  test "admin should update post" do
    login_admin
    put :update, id: @post, post: { body: @post.body, topic_id: @post.topic_id, user_id: @post.user_id }
    assert_redirected_to '/topics/'+@post.topic_id.to_s
  end

  #test "user should update own post" do
   # login_user
    #put :update, id: @post, post: { body: @post.body, topic_id: @post.topic_id, user_id: @post.user_id }
    #assert_redirected_to '/topics/'+@post.topic_id.to_s
  #end

  test "anon should not update post" do
    put :update, id: @post, post: { body: @post.body, topic_id: @post.topic_id, user_id: @post.user_id }
    assert_redirected_to '/'
  end

  #test "admin should destroy post" do
    #login_admin
    #t=@post.topic_id
   # assert_difference('Post.count', -1) do
  #    delete :destroy, id: @post
 #   end
#
   # assert_redirected_to '/topics/'+@topic.id.to_s
  #end

  test "user should not destroy post" do
    login_user
    assert_difference('Post.count', 0) do
      delete :destroy, id: @post
    end

    assert_redirected_to '/'
  end

  test "anon should not destroy post" do
    login_user
    assert_difference('Post.count', 0) do
      delete :destroy, id: @post
    end

    assert_redirected_to '/'
  end
end
