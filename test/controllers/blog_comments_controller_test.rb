require "test_helper"

class BlogCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_comments_index_url
    assert_response :success
  end
end
