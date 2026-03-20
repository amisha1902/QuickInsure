class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: [:show, :destroy]
  def index
    if params[:post_id]
      comments = Comment.all.where(post_id: params[:post_id])
    else
      comments = Comment.all
    end
    render json: comments
  end

  def show
    render json: @comment
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: "Comment deleted successfully" }
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:content, :post_id, :user_id)
  end
end