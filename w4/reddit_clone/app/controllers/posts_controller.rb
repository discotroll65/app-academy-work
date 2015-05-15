class PostsController < ApplicationController
  before_action :ensure_author, only:[:edit, :update]
  before_action :ensure_moderator, only:[:delete]
  before_action :ensure_logged_in!


  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user_id

    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @author = @post.author
    @sub = @post.sub
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = @post.sub
    @post.destroy
    redirect_to @sub
  end

  private
    def ensure_author
      redirect_to :back unless current_user_id == author_id
    end

    def ensure_moderator
      post = Post.find(params[:id])
      redirect_to :back unless current_user_id == post.sub.moderator_id
    end

    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_id)
    end
end
