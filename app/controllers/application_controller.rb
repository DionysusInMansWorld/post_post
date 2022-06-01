class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

    def existed_user
      unless exist_user?
        flash[:danger] = "未登录且未领取饼干"
        redirect_to root_url
      end
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "未登录"
        redirect_to login_url
      end
    end

    def is_cookie
      unless is_cookie?
        flash[:danger] = "无饼干"
        redirect_to root_url
      end
    end

    def not_logged_in
      if logged_in?
        flash[:danger] = "已登录"
        redirect_to root_url
      end
    end

    def is_not_cookie
      if is_cookie?
        flash[:danger] = "已经拥有饼干"
        redirect_to root_url
      end
    end

    def no_user
      not_logged_in
      is_not_cookie
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "不是对应账户"
        redirect_to root_url
      end
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "不是管理员账户"
        redirect_to root_url
      end
    end
end
