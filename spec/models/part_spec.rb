require 'spec_helper'

describe Part do
  it "should not be valid" do
  	@part = Part.new title: "title"
  	@part.should_not be_valid
  	@part.title=nil
  	@part.desc="desc"
  	@part.should_not be_valid
  	@part.title="t"
  	@part.should_not be_valid
  	@part.title="title"*9
  	@part.should_not be_valid
  	@part.title="title"
  	@part.desc="descr"*9
  	@part.should_not be_valid
  	@part = Part.new
    @part.should_not be_valid
  end

  it "should be valid" do
  	@part=Part.new title: "title", desc: "desc"
  	@part.should be_valid
  end
  
end
