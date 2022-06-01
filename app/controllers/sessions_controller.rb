class SessionsController < ApplicationController
  before_action :not_logged_in, only: [:new, :create]
  before_action :logged_in_user, only: :destroy

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate?(:password, params[:session][:password])
      log_in user
      redirect_back_or user
    else 
      flash.now[:danger] = '无效的用户名和密码组合'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
