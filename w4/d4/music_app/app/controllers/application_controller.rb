class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user
  end

  def login!(user)
    session[:session_token] = reset_session_token!(user)
  end

  def logout!
    reset_session_token!(current_user)
    session[:session_token] = nil
  end
  def reset_session_token!(user)
    user.session_token = SecureRandom::urlsafe_base64
    user.save!
    user.session_token
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
