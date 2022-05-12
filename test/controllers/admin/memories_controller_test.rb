require "test_helper"

class Admin::MemoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_memories_destroy_url
    assert_response :success
  end
end
