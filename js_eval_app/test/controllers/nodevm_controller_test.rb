require "test_helper"

class NodevmControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nodevm_index_url
    assert_response :success
  end

  test "should get show" do
    get nodevm_show_url
    assert_response :success
  end
end
