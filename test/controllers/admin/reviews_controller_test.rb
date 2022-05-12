require "test_helper"

class Admin::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_reviews_destroy_url
    assert_response :success
  end
end
