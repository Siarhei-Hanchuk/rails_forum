require 'spec_helper'

describe PartsHelper do

	describe "to_date" do

		# it "convert to date" do
		# 	helper.to_date().should == ''
		# end

	end

	describe "imgurl" do
		it 'should return /ava.png' do
			user=User.create
			helper.imgurl(user).should == '/ava.png'
		end
		it 'should return ava' do
			user=User.create
			user.ava='a'
			helper.imgurl(user).should == 'a'
		end
	end

	describe 'show_user_login' do
		it 'should return USER REMOVED' do
			user=nil 
			helper.show_user_login(user).should == 'USER REMOVED'
		end

		it 'should return username' do
			user=User.create username: 'name'
			helper.show_user_login(user).should == 'name'
		end
	end

end
