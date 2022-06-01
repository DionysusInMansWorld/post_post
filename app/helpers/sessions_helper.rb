module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !user_logged_in.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def user_logged_in #should find by at each time, and wait for improvement
    @user_logged_in ||= User.find_by(id: session[:user_id])
  end

  def current_user
    @current_user ||= existing_user
  end

  def current_user?(user)
    user == current_user
  end

  def remember(user)
    cookies.signed[:user_id] = { value:   user.id,
                                 expires: 100.years.from_now.utc }
    cookies.signed[:remember_token] = { value:   user.remember_token,
                                 expires: 100.years.from_now.utc }
  end

  def forget
    cookie_user.destroy
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @cookie_user = nil
  end

  def cookie_user #should find by at each time, and wait for improvement
    if @cookie_user.nil?
      user = User.find_by(id: cookies.signed[:user_id])
      @cookie_user = user if user && user.authenticate?(:remember, cookies.signed[:remember_token])
    else
      @cookie_user
    end
  end

  def is_cookie?
    !cookie_user.nil?
  end

  def existing_user
    if logged_in?
      user_logged_in
    elsif is_cookie?
      cookie_user
    end
  end

  def exist_user?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
