require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "valid" do
  	comment=Comment.create(body: "sssssss")
    assert comment.valid?
    comment.body=""
    assert comment.invalid?
    comment.body="01234567890"*30
    assert comment.invalid?
  end
end
