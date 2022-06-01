require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @base_title = "PostPost"
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should create a new user" do
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Tesuto!",
                                          password:              "Foo Bar ",
                                          password_confirmation: "Foo Bar " } }
    end

    assert_redirected_to user_path(assigns(:user))
  end
 
  test "should get show" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_response :success
  end

  test "should update a user" do
    log_in_as(@user)
    old_name = @user.name
    patch user_path(@user), params: { user: { name: "Right!" } }

    assert_not_equal old_name, @user.reload.name
  end

  test "should get index" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_response :success
  end

  test "should destory a user" do
    log_in_as(@user)

    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in as admin" do
    log_in_as(@other_user)
    get users_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end


  test "shouldn't allow the user's state to be edited via in the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                  user: { state: 1} }
    assert_not @other_user.admin?
  end

  test "should delete a user when logged in admin" do
    log_in_as(@user)
    get users_path
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end
end
