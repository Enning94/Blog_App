class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])

    # @posts = @user.posts.includes(:comments)
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
    if @post.save
      flash[:success] = 'User posted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Post not saved'
      render :new, status: :unprocessable_entity
    end
  end
end
