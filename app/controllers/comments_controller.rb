class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
    respond_to(&:html)
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @user

    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:errors] = 'Error: Comment could not be saved'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    author = @comment.post.author
    post = @comment.destroy
    if @comment.destroy
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'Error! Please try again later.'
    end
    redirect_to user_post_url(author, post)
  end
  private

  def comment_params
    params
      .require(:comment)
      .permit(:text)
     end
end
