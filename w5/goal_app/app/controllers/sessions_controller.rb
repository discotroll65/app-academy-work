class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid Username or Password."]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end

end
