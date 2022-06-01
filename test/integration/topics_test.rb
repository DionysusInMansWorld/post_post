require 'test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @topic = topics(:main)
  end

  test "index display" do
    get topics_path
    assert_template 'topics/index'

    Post.page(1).each do |post|
      assert_match post.content, response.body
    end
  end

  test "show display" do
    get topic_path(@topic)
    assert_template 'topics/show'

    @topic.posts.page(1).each do |post|
      assert_match post.content, response.body
    end
  end
end
