class Api::V1::LikesController < ApplicationController
  def index
    @likes = Like.where(post_id: post.id)
    render json: @likes
  end

  def show
    render json: @like
  end

  def create
    @like = Like.new(like_params)

    if @like.save
      render json: @like, status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end

  def user
    @user = User.find(params[:user_id])
  end

  def post
    @post = Post.find(params[:post_id])
  end
end
