require 'spec_helper'

describe Topic do

	it "should not be valid" do
		@topic = Topic.new part_id: 1, user_id: 1
		@topic.should_not be_valid
		@topic.title="t"
		@topic.should_not be_valid
	end

	it "should be valid" do
		@topic = Topic.new title: "title", part_id: 1, user_id: 1
		@topic.should be_valid
	end
	
end
