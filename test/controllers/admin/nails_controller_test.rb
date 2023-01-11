require "test_helper"

class Admin::NailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_nails_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_nails_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_nails_destroy_url
    assert_response :success
  end
end
