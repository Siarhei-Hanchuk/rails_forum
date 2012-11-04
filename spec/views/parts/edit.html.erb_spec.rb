require 'spec_helper'

describe "parts/edit" do
  before(:each) do
    @part = assign(:part, stub_model(Part,
      :title => "Part1",
      :desc => "descr"
    ))
  end

  it "renders the edit lolol form" do
    render
    assert_select "form", :action => parts_path(@part), :method => "post" do
      assert_select "input#part_title", :name => "part[login]"
      assert_select "input#part_desc", :name => "part[desc]"
    end
  end
end
