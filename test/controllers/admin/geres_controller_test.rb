require "test_helper"

class Admin::GeresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_geres_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_geres_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_geres_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_geres_update_url
    assert_response :success
  end
end
