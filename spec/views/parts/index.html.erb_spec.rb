require 'spec_helper'

describe "parts/index" do
  before(:each) do
    assign(:parts, [
      stub_model(Part,
        :title => "Name",
        :desc => "descr"
      ),
      stub_model(Part,
        :title => "Name",
        :desc => "descr"
      )
    ])
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders a list of parts" do
    render
    assert_select "tr>td", :text => "Namedescr", :count => 2
  end
end
