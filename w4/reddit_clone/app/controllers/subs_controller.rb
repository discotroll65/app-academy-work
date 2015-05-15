class SubsController < ApplicationController
  before_action :ensure_logged_in!

  def index
    @subs = Sub.all

    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user_id

    if @sub.save
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.includes(:posts).find(params[:id])
    @posts = @sub.posts
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
