class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :log_out, :auth_token

  def logged_in?
    redirect_to new_session_url unless current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def auth_token
    html = "<input type='hidden' "
    html += "name='authenticity_token' "
    html += "value=#{form_authenticity_token}>"

    html.html_safe
  end
end
