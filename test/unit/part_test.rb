require 'test_helper'

class PartTest < ActiveSupport::TestCase
  test "valid" do
    part=Part.create(title: 'QWE', desc: '_')
    assert part.valid?
    part.title=''
    assert part.invalid?
    part.title='0'*50
    assert part.invalid?
    part.title="ssssssssssss"
    part.desc="0"*50
    assert part.invalid?
  end
end
