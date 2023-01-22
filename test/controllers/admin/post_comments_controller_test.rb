require "test_helper"

class Admin::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_comments_index_url
    assert_response :success
  end

  test "should get confirm" do
    get admin_post_comments_confirm_url
    assert_response :success
  end
end
