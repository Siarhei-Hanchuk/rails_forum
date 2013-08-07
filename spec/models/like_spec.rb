require 'spec_helper'

describe Like do

	it "should be valid" do
		like=Like.new
		like.should be_valid
	end

end
