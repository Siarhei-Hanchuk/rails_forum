require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #like" do
      get("/ajax/like?post_id=1").should route_to("ajax#like")
    end

    it "routes to #like_logins" do
      get("/ajax/like_logins?post_id=1").should route_to("ajax#like_logins")
    end

    it "routes to #comment" do
      post("/ajax/comment").should route_to("ajax#comment")
    end

  end
end
