require 'spec_helper'

describe PartsController do

	before(:each) do
		@part = Part.create title: 'title', desc: 'descr'
		@part.save
	end

	describe "auth or anon user" do
		login
		
		it "should get index" do
			get :index
			response.should be_success
		end

		it "should not not get new" do
			get :new
			response.should_not be_success
		end

		it "should not post create" do
			post :create
			response.should_not be_success
		end

		it "should get show" do
			get :show, id: @part.id
			response.should be_success
		end

		it "should not delete destroy" do
			c=Part.count
			delete 'destroy', id: @part.id
			response.should redirect_to '/'
			Part.count.should be(c)
		end

		it "should not put update" do
			@part.title='title2'
			attrs=@part.attributes
			attrs.delete 'created_at'
			attrs.delete 'updated_at'
			attrs.delete 'id'
			put 'update', id: @part.id, part: attrs
			response.should redirect_to('/')
		end
	end

	describe "admin user" do
		login :admin
		
		it "should get index" do
			get :index
			response.should be_success
		end

		it "should get new" do
			get :new
			response.should be_success
		end

		it "should post create" do
			post :create
			response.should be_success
		end

		it "should get show" do
			get :show, id: @part.id
			response.should be_success
		end

		it "should delete destroy" do
			c=Part.count
			delete 'destroy', id: @part.id
			response.should redirect_to '/parts'
			Part.count.should be(c-1)
		end

		it "should put update" do
			@part.title='title2'
			attrs=@part.attributes
			attrs.delete 'created_at'
			attrs.delete 'updated_at'
			attrs.delete 'id'
			put 'update', id: @part.id, part: attrs
			response.should redirect_to(@part)
			@part.title.should eq('title2')
		end

	end

end
