require 'spec_helper'

describe PostsController do

	before(:each) do
		@part = Part.create title: 'title', desc: 'descr'
		@part.save
		@topic= Topic.create title: 'ttitle', part_id: @part.id, user_id:-11
		@topic.save				
		@post = Post.create body: 'body', topic_id: @topic.id, user_id:-11
		@post.save
	end

	describe "anon user" do

		it "should not get edit" do
			get 'edit', id: @post.id
			response.should_not be_success
		end

		it "should not post create" do
			post :create, post: @post.attributes
			response.should redirect_to '/'
		end

		it "should not delete destroy" do
			delete 'destroy', id: @post.id
			response.should redirect_to '/'
		end

		it "should not put update" do
			@post.body='body2'
			put 'update', id: @post.id, post: @post.attributes
			response.should redirect_to '/'
		end

 	end

 	describe "simple user" do
 		login

		it "should not get edit" do
			get 'edit', id: @post.id
			response.should_not be_success
		end

		it "should get own" do
		 	@post.user_id=session[:user_id]
		 	@post.save
		 	get 'edit', id: @post.id
		 	response.should be_success
		end

		it "should post create" do
		 	post :create, post: @post.attributes
		 	response.should redirect_to('/topics/'+@topic.id.to_s+'?page=1#'+(@post.id+1).to_s)#!!!!!!!!!!!!!!!!!!!!!!!!!
		end

		it "should not delete destroy" do
			delete 'destroy', id: @post.id
			response.should redirect_to '/'
		end

		it "should not put update" do
			@post.body='body2'
			put 'update', id: @post.id, post: @post.attributes
			response.should redirect_to '/'
		end

		it "should put update own" do
			@post.body='body2'
			@post.user_id=session[:user_id]
			@post.save
			put 'update', id: @post.id, post: @post.attributes
			response.should redirect_to('/topics/'+@topic.id.to_s)
		end
		
 	end

describe "admin user" do
	login :admin

	it "should get edit" do
		get 'edit', id: @post.id
		response.should be_success
	end

	it "should delete destroy" do
		delete 'destroy', id: @post.id
		response.should redirect_to '/parts/'+@part.id.to_s
	end

	it "should put update" do
		@post.body='body2'
		put 'update', id: @post.id, post: @post.attributes
		response.should redirect_to('/topics/'+@topic.id.to_s)
	end

end

end
