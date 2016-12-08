class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :log_out

  def logged_in?
    current_user ? true : false
  end

  def current_user
    user = User.find_by(session_token: session[:session_token])
    @current_user ||= (user ? user : nil)
  end

  def log_in(user)
    session_token = user.reset_session_token!
    session[:session_token] = session_token
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
