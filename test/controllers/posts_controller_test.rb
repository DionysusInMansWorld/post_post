require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @topic = topics(:main)
  end

  test "should get show" do
    post = posts(:post_30)
    get post_path(post)
    assert_response :success
    assert_select "title", "#{post.title} | PostPost"
  end

  test "should redirect to the topic" do
    log_in_as(@user)
    post = posts(:post_30)
    delete post_path(post)
    assert_redirected_to topic_url(post.topic)
  end

  test "should create a new post" do
    log_in_as(@user)
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: "Tesuto!",
                                         title:   "This is only a title!",
                                         topic_id: @topic.id } }
    end
    assert_redirected_to topics_url
  end

  test "should redirect create when there isn't a user" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Tesuto!", 
                                         title:   "This is only a title!",
                                         topic_id: @topic.id} }
    end
    assert_redirected_to root_url
  end

  test "should delete a post" do
    log_in_as(@user)
    post = posts(:orange)
    assert_difference 'Post.count', -1 do
      delete post_path(post)
    end
    assert_redirected_to topics_url
  end

  test "should redirect delete when there isn't a user" do
    post = posts(:orange)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

  test "should redirect delete when user isn't correct" do
    log_in_as(users(:archer))
    post = posts(:orange)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end
end
