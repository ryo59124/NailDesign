require "test_helper"

class Public::NailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_nails_index_url
    assert_response :success
  end

  test "should get show" do
    get public_nails_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_nails_edit_url
    assert_response :success
  end

  test "should get create" do
    get public_nails_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_nails_destroy_url
    assert_response :success
  end

  test "should get update" do
    get public_nails_update_url
    assert_response :success
  end
end
