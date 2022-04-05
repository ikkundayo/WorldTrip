require "test_helper"

class Admin::CountriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_countries_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_countries_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_countries_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_countries_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_countries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_countries_destroy_url
    assert_response :success
  end
end
