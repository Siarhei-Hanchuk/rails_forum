require 'spec_helper'
require "cancan/matchers"

describe Ability do

	it "user" do
		user=User.create
		user.save
		ability = Ability.new(user)
		ability.should be_able_to(:edit, Post.new(:user_id => user.id))
		ability.should be_able_to(:show, Part.new)
		#user.roles=(user.roles<<:admin)
		#ability.should_not be_able_to(:edit, Post.new(:user_id => user.id+1))
		#ability.should_not be_able_to(:destroy, Post.new(:user_id => user.id))		
		#ability.should be_is(:admin)
	end

end