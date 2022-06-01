require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "PostPost"
  end
 
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "首页 | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "帮助 | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "联系我 | #{@base_title}"
  end
end
