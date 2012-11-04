require 'spec_helper'

describe "parts/new" do
  before(:each) do
    assign(:part, stub_model(Part,
      :title => "title",
      :desc => "descr"
    ).as_new_record)
  end

  it "renders new lolol form" do
    render

    assert_select "form", :action => parts_path, :method => "post" do
      assert_select "input#part_title", :name => "lolol[title]"
      assert_select "input#part_desc", :name => "lolol[desc]"
    end
  end
end
