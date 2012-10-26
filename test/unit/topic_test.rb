require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "valid" do
  	topic=Topic.create(title: "title", user_id: 1)
    assert topic.invalid?
    topic.part_id=1
    assert topic.valid?
    topic.title="ss"
    assert topic.invalid?
  end
end
