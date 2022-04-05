require "test_helper"

class Public::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_categories_create_url
    assert_response :success
  end
end
