class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @sub = @post.sub
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user_id

    @post = @comment.post
    @some_sub = @post.subs.first
    if @comment.save

      redirect_to sub_post_url(@some_sub, @post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @sub_comments = @comment.sub_comments
    render :show
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
