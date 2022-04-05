require "test_helper"

class Public::HintsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_hints_index_url
    assert_response :success
  end

  test "should get show" do
    get public_hints_show_url
    assert_response :success
  end

  test "should get new" do
    get public_hints_new_url
    assert_response :success
  end

  test "should get create" do
    get public_hints_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_hints_destroy_url
    assert_response :success
  end
end
