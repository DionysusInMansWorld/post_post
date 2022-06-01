class TopicsController < ApplicationController
  def index
    @posts = Post.page params[:page]
    @post = current_user.posts.build if exist_user?

    @topics = Topic.all
    @topic = Topic.first

    @reply = current_user.replies.build if exist_user?
  end

  def show
    @topics = Topic.all
    @topic = Topic.find(params[:id])

    @posts = @topic.posts.page params[:page]
    @post = current_user.posts.build if exist_user?

    @reply = current_user.replies.build if exist_user?
  end
end