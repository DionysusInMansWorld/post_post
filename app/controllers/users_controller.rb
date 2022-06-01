class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:index, :destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @reply = @user.replies.build
    @feed_items = current_user.feed.page params[:page]
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "注册成功"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(existing_params)
      flash[:success] = "资料更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.page params[:page]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除"
    redirect_to users_url
  end

  private
    
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def existing_params
      params = Hash.new

      user_params.each do |k, v|
        params[k] = v unless v.nil? || v.empty?
      end

      params
    end
end
