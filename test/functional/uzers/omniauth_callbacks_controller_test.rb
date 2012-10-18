require 'test_helper'

class Uzers::OmniauthCallbacksControllerTest < ActionController::TestCase
  test "should get facebook" do
    get :facebook
    assert_response :success
  end

end
