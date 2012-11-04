require 'spec_helper'

describe SearchController do

	describe "Search" do

		it "posts" do
			arr={}
			arr[:contactmethod]='posts'
			post 'index', text: 'text', gender: arr
			response.should be_success
		end

		it "topics" do
			arr={}
			arr[:contactmethod]='topics'
			post 'index', text: 'text', gender: arr
			response.should be_success
		end

	end

end
