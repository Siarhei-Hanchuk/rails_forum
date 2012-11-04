require 'spec_helper'

describe AjaxController do
	login

	before(:each) do
		@part = Part.create title: 'title', desc: 'descr'
		@part.save
		@topic= Topic.create title: 'ttitle', part_id: @part.id, user_id: session[:user_id]
		@topic.save				
		@post = Post.create body: 'body', user_id: session[:user_id], topic_id: @topic.id
		@post.save
	end


	describe 'comment' do
		it 'create' do
			c=Comment.count+1
			post 'comment', post_id: 1, comment: 'comment'
			response.status.should be(200)
			Comment.count.should be(c)
			post 'comment'
			Comment.count.should be(c)
			session[:user_id]=nil
			post 'comment', post_id: 1, comment: 'comment'
			Comment.count.should be(c)
		end

	end

	describe 'like' do
		it 'create' do
			Like.delete_all
			c=Like.count
			get 'like', post_id: @post.id
			Like.count.should be(c+1)
			get 'like', post_id: @post.id
			Like.count.should be(c)
			session[:user_id]=nil
			get 'like', post_id: @post.id
			Like.count.should be(c)
		end
	end

	describe 'like_logins' do
		it 'get' do
			get 'like_logins', post_id: @post.id
			response.body.should eq('')
		end

	end

end
