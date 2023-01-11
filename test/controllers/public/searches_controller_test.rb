require "test_helper"

class Public::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search_sns" do
    get public_searches_search_sns_url
    assert_response :success
  end

  test "should get search_review" do
    get public_searches_search_review_url
    assert_response :success
  end

  test "should get search_cafe" do
    get public_searches_search_cafe_url
    assert_response :success
  end
end
