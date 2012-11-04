require 'spec_helper'

describe "parts/show" do
  include Devise::TestHelpers
  before(:each) do
  	@part = assign(:part, stub_model(Part,
      :title => "title",
      :desc => "descr"
    ))
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders attributes in <p>" do
    @topics=@part.topics
    @topics=Kaminari.paginate_array(@topics).page(params[:page]).per(5)
    render
    rendered.should match(/title/)
    rendered.should match(/descr/)
  end
end
