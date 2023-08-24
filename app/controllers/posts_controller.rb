class PostsController < ApplicationController

  def index
   @user = User.find_by(id: params[:user_id])
   
      @posts = @user.posts.includes(:comments)

  end

  def show;
    @post = Post.includes(:author, comments: :author).find(params[:id])
  end
end
