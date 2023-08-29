class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = Post.includes(:author).paginate(page: params[:page], per_page: 3)
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
end
