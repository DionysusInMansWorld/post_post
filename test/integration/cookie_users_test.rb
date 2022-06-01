require 'test_helper'

class CookieUsersTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "create a valid cookie user then delete it" do
    post cookie_path
    assert cookies[:user_id]
    assert cookies[:remember_token]
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?

    delete cookie_path
    assert_empty cookies[:user_id]
    assert_empty cookies[:remember_token]
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end
end
