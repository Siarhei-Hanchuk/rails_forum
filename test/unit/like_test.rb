require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "correct" do
  	like=Like.new(:user_id=>5, :post_id=>2)
  	assert like.valid?
  	#like.user_id=0
  	#assert like.invalid?
  	#like.user_id=4
  	#like.post_id=-1
  	#assert like.invalid?
  end
end
