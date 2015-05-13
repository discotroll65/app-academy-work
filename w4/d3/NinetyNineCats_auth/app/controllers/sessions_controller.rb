class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if @user.nil?
      @user = User.new(user_params)
      flash.now[:errors] = "User name/password incorrect"
      render :new
    else
      flash[:success] = "Logged in!"
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    end
  end
end
