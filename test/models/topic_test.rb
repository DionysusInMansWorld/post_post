require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @topic = Topic.new(name: "综合")
  end

  test "Name should be present" do
    @topic.name = " "
    assert_not @topic.valid?
  end

  test "Name length shouldn't be longer than 64 letters" do
    @topic.name = "a" * 65
    assert_not @topic.valid?
  end
end
