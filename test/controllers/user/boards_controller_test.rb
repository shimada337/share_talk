require "test_helper"

class User::BoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_boards_index_url
    assert_response :success
  end

  test "should get show" do
    get user_boards_show_url
    assert_response :success
  end
end
