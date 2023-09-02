class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @comments = Comment.where(post_id: post.id)
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    comment = Comment.new(comment_params)
    comment.post = @post
    comment.author = current_user
    if comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:post_id]}"
    else
      flash.now[:error] = 'Error: comment could not be saved'
      redirect_to new_comment
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end

  def user
    @user = User.find(params[:user_id])
  end

  def post
    @post = Post.find(params[:post_id])
  end
end
