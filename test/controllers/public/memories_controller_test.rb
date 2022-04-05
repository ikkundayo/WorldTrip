require "test_helper"

class Public::MemoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_memories_index_url
    assert_response :success
  end

  test "should get show" do
    get public_memories_show_url
    assert_response :success
  end

  test "should get new" do
    get public_memories_new_url
    assert_response :success
  end

  test "should get create" do
    get public_memories_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_memories_destroy_url
    assert_response :success
  end
end
