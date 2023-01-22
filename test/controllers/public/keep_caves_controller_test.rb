require "test_helper"

class Public::KeepCavesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_keep_caves_index_url
    assert_response :success
  end
end
