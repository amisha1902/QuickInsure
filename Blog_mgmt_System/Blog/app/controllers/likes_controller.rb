class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post

  def index
    @likes = @post.likes
    render json: @likes
  end

  def create
    user_id = params[:user_id]

    if user_id.blank?
      render json: { message: "you liked this post" }, status: :bad_request and return
    end

    @like = @post.likes.find_by(user_id: user_id)

    if @like
      @like.destroy
      render json: { message: "you unliked this post" }
    else
      @like = @post.likes.new(user_id: user_id)

      if @like.save
        render json: { message: "post liked by you"}
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])

    unless @post
      render json: { error: "Post not found" }, status: :not_found and return
    end
  end
end