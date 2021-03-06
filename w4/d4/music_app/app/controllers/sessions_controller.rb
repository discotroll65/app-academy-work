class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if @user.nil?
      @user = User.new(user_params)
      flash.now[:errors] = ["Incorrect Email / Password combo"]
      render :new
    else
      login!(@user)
      redirect_to root_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end




end
