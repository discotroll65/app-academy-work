class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method(
    :current_user,
    :log_in!,
    :logged_in?,
    :log_out!,
    :current_user_id
  )

  def current_user
    user = User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in!
    redirect_to new_session_url unless logged_in?
  end

  def current_user_id
    current_user.id
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
