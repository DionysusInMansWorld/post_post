require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "should get new" do
    get login_path
    assert_template 'sessions/new'
    assert_response :success
  end

  test "should create a session" do
    post login_path, params: { session: { name: @user.name,
                                          password: "password" } }
    assert_redirected_to user_url(@user)
    assert is_logged_in?
  end

  test "should destroy the session" do
    log_in_as(@user)
    delete logout_path
    assert_not is_logged_in?
  end

  test "should redirect new when logged in" do
    log_in_as(@user)
    get login_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect post when logged in" do
    log_in_as(@user)
    post login_path, params: { session: { name: @user.name,
                                          password: "password" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    delete logout_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
