require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Normal user", password:              "password",
                                          password_confirmation: "password")
    @cookie = User.new_cookie_user
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 65
    assert_not @user.valid?
  end

  test "name should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "state should be present" do
    @user.state = nil
    assert_not @user.valid?
  end

  test "password should can be empty with cookie" do
    @user.be(:cookie)
    @user.password              = nil
    @user.password_confirmation = nil
    assert @user.valid?
  end

  test "password should can be present" do
    @user.password              = nil
    @user.password_confirmation = nil
    assert_not @user.valid?
  end

  test "password shouldn't be too short" do
    @user.password              = "a" * 7
    @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "password shouldn't be too long" do
    @user.password              = "a" * 33
    @user.password_confirmation = "a" * 33
    assert_not @user.valid?
  end

  test "password should be digested" do
    @user.password_digest = @user.password
    @user.save
    assert_not_equal @user.password, @user.password_digest
  end

  test "password should be the same of password_confirmation" do
    @user.password = "12345687"
    assert_not @user.valid?
  end

  test "password shouldn't be blank" do
    @user.password = " " * 8
    @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "authentication should be succeeded" do
    @user.save
    assert @user.authenticate?(:password, @user.password)
  end

  test "unsuccessful authentications" do
    user = @user.dup
    user.name = "1"
    user.password              = nil
    user.password_confirmation = nil
    user.save
    assert_not user.authenticate?(:password, user.password)

    @user.save
    assert_not @user.authenticate?(:password, "Wrong password")
  end

  test "should create a valid cookie user" do
    assert @cookie.valid?
  end

  test "should create a normal user" do
    assert_equal :normal, User.new().is?
  end
end
