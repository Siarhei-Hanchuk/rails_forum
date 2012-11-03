require "spec_helper"

describe SearchController do
  describe "routing" do

    it "routes to #index" do
      post("/search/index").should route_to("search#index")
    end

  end
end
