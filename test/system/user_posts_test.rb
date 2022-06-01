require "application_system_test_case"

class UserPostsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit user_posts_url
  #
  #   assert_selector "h1", text: "UserPost"
  # end

  def setup
    @user  = users(:michael)
    @topic = topics(:main)
  end
end
