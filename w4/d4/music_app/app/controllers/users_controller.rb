class UsersController < ApplicationController
  def new
    #signup page
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user
    unless @user
      redirect_to new_session_url
    else
      render :show
    end
  end



end
