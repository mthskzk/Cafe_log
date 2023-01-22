require "test_helper"

class Admin::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reviews_index_url
    assert_response :success
  end

  test "should get confirm" do
    get admin_reviews_confirm_url
    assert_response :success
  end
end
