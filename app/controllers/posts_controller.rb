class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
  end

  def show
    @post = Post.includes(:author, comments: :author).find(params[:id])
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @user = current_user
    @post.author = @user
    @post.save
    flash[:success] = 'User posted successfully'
    redirect_to user_posts_path(@user)
  end

  def destroy
    user = current_user
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
    @post.likes.destroy_all
    @post.comments.destroy_all

    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = 'Error! Please try again later.'
    end
    redirect_to user_posts_path(user)
  end
end
