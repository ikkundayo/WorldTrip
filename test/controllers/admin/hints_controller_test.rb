require "test_helper"

class Admin::HintsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_hints_destroy_url
    assert_response :success
  end
end
