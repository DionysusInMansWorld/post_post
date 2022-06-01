require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user  = users(:havent_got_a_post)
    @topic = topics(:main)
    @post  = @user.posts.build(content: "Tesuto!", title: "This is only a title!", topic: @topic)
  end

  test "shoule be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "topic id should be present" do
    @post.topic_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "title should be present" do
    @post.title = nil
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "associated posts should be destroyed" do
    @user.save
    @post.save
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end
end
