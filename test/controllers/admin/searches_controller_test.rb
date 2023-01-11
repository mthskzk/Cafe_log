require "test_helper"

class Admin::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search_sns" do
    get admin_searches_search_sns_url
    assert_response :success
  end

  test "should get search_review" do
    get admin_searches_search_review_url
    assert_response :success
  end

  test "should get search_cafe" do
    get admin_searches_search_cafe_url
    assert_response :success
  end
end
