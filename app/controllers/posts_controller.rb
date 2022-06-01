class PostsController < ApplicationController
  before_action :existed_user, only: [:index, :create, :destroy]
  before_action :correct_user_unless_admin, only: [:destroy]
  before_action :admin_user,   only: [:index]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "发串成功"
    else
      flash[:danger] = "请勿空发"
    end

    redirect_to index_or(@post.topic)
  end

  def destroy
    post = @post if @post
    post = Post.find(params[:id]) if post.nil?
    post.destroy

    flash[:success] = "串已删除"
    redirect_to index_or(post.topic)
  end

  def show
    @post = Post.find(params[:id])
    @reply = current_user.replies.build if exist_user?
    @replies = @post.replies.page(params[:page])

    if params[:page].nil? 
      @offset = 0
    else 
      @offset = (params[:page].to_i - 1) * 25
    end
  end

  def index 
    @posts = Post.page params[:page]
  end

  private

    def post_params
      params.require(:post).permit(:content, :topic_id, :title)
    end

    def correct_user_unless_admin
      unless current_user.admin?
        @post = current_user.posts.find_by(id: params[:id])
        if @post.nil?
          flash[:danger] = "你不能删除不属于自己的串"
          redirect_to root_url 
        end
      end
    end

    def index_or(topic)
      if topic.id == 1  
        topics_url
      else
        topic_url(topic)
      end
    end
end
