require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @topic = topics(:main)
  end

  test "should get index" do
    get topics_path
    assert_response :success
  end

  test "should get show" do
    get topic_path(@topic)
    assert_response :success
  end
end
