class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  helper_method :logged_in?, :current_user, :current_user_id

  #current_user to return the current user.
#logged_in? to return a boolean indicating whether someone is signed in.
#log_in_user!(user) reset the users session token and cookie
end
