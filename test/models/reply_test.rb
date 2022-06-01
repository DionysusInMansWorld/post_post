require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user  = users(:michael)
    @post  = posts(:orange)
    @reply = @user.replies.build(content: "Tesuto", post: @post)
  end

  test "content should be existed" do
    @reply.content = ""
    assert_not @reply.valid?
  end
end
