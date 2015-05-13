class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_user, :user_owns_cat?

  def current_user
    user = User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def user_owns_cat?(cat)
    cat.user_id == current_user.id
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_not_logged_in
    redirect_to cats_url if current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless current_user
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
