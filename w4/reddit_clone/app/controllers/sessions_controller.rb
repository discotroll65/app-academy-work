class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])

    if @user
      log_in!(@user)
      redirect_to root_url
    else
      @user = User.new(session_params)
      flash.now[:errors] = ["Invalid username/password combo."]
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  private
    def session_params
      params.require(:user).permit(:username, :password)
    end
end
