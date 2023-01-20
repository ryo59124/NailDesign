require "test_helper"

class ConfirmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get confirms_index_url
    assert_response :success
  end
end
