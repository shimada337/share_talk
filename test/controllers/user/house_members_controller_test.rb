require "test_helper"

class User::HouseMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_house_members_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_house_members_edit_url
    assert_response :success
  end
end
