require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  include SessionsHelper
  # Add more helper methods to be used by all tests here...

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:used_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { name: user.name,
                                          password: password } }
  end
end