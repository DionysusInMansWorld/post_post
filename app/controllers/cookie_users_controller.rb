class CookieUsersController < ApplicationController
  before_action :no_user, only: :create
  before_action :is_cookie, only: :destroy

  def create
    user = User.new_cookie_user
    if user.save
      remember user
      flash[:success] = "饼干获取成功"
      redirect_to root_url
    else
      flash[:danger] = "饼干获取失败"
      redirect_to root_url
    end  
  end

  def destroy
    forget
    flash[:success] = "饼干删除成功"
    redirect_to root_url
  end
end
