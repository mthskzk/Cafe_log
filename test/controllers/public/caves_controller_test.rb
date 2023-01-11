require "test_helper"

class Public::CavesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_caves_index_url
    assert_response :success
  end

  test "should get show" do
    get public_caves_show_url
    assert_response :success
  end
end
