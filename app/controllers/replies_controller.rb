class RepliesController < ApplicationController
  def create
    @reply = current_user.replies.build(reply_params)

    if @reply.save
      flash[:success] = "回复成功"
      @reply.post.touch
    else
      flash[:danger]  = "回复失败"
    end

    redirect_back fallback_location: topics_url
  end

  private

    def reply_params
      params.require(:reply).permit(:content, :post_id)
    end
end
