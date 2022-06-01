require 'test_helper'

class CookieUsersControllerTest < ActionDispatch::IntegrationTest
  
  test "should create a cookie user" do
    assert_difference "User.count", 1 do
      post cookie_path
    end  
  end

  test "should redirect create when there has be a user" do
    post cookie_path

    assert_no_difference "User.count" do
      post cookie_path
    end  

    assert_redirected_to root_url
  end

  test "should redirect create when logged in" do
    log_in_as(users(:michael))

    assert_no_difference "User.count" do
      post cookie_path
    end

    assert_redirected_to root_url
  end

  test "should destroy a cookie user" do
    post cookie_path

    assert_difference "User.count", -1 do
      delete cookie_path
    end
  end

  test "should redirect destroy when no cookie user" do
    assert_no_difference "User.count" do
      delete cookie_path
    end

    assert_redirected_to root_url
  end
end
