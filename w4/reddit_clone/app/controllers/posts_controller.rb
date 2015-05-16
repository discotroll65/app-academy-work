class PostsController < ApplicationController
  before_action :ensure_author, only:[:edit, :update]
  before_action :ensure_moderator, only:[:delete]
  before_action :ensure_logged_in!


  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    @all_subs = Sub.all
    @post_subs = @post.subs
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user_id
    @sub = Sub.find(params[:post][:sub_id])
    @all_subs = Sub.all
    @post_subs = @post.subs

    if @post.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:post][:sub_id])
    @all_subs = Sub.all
    @post_subs = @post.subs
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @all_subs = Sub.all
    @post_subs = @post.subs
    if @post.update(post_params)
      redirect_to sub_post_url(params[:post][:sub_id], @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.where(id: params[:id]).includes(:author).first

    # @comments = (
    #   @post.comments
    #   .where(parent_comment_id: nil).includes(:author)
    # )
    @comment_tree = @post.comment_tree_hash
    @author = @post.author
    @sub = Sub.find(params[:sub_id])

    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end

  private
    def ensure_author
      post = Post.find(params[:id])
      redirect_to :back unless current_user_id == post.author_id
    end

    def ensure_moderator
      post_id = params[:id]
      sub_moderator_ids= Sub.select('moderator_id')
        .joins(:post_subs)
        .where('post_subs.post_id = ?', post_id)

      redirect_to :back unless sub_moderator_ids.include?(current_user_id)
    end

    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids:[])
    end
end
