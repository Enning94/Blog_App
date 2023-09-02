class Api::V1::CommentsController < ApplicationController
    def index
      @comments = Comment.where(post_id: post.id)
      render json: @comments
    end
  
    def show
      render json: @comment
    end
  
    def create
      @comment = Comment.new(comment_params)
  
      if @comment.save
        render json: @comment, status: :created, location: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
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
end
