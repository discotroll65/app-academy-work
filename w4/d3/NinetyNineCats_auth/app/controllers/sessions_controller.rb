class SessionsController < ApplicationController
  before_action :ensure_not_logged_in, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if @user.nil?
      @user = User.new(user_params)
      flash.now[:errors] = [ "User name/password incorrect"]
      render :new
    else
      flash[:success] = ["Logged in!"]
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
