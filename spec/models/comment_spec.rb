require 'spec_helper'

describe Comment do

	it "should not be valid" do
		@comment = Comment.new user_id: 1, post_id: 1
		@comment.should_not be_valid
		@comment.body="comet"*100
		@comment.should_not be_valid
	end

	it "should be valid" do
		@comment = Comment.new body: "comment", user_id: 1, post_id: 1
		@comment.should be_valid
	end
	
end
