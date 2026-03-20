class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end
  def show
  post = Post.find(params[:id])
  render json: post
  end
  def create          
    post = Post.new(post_params)
    if post.save
      render json: post.as_json.merge( category_names: post.categories.pluck(:category_name)), status: :created 
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end
  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { message: "Post deleted successfully" }
  end

  def by_category
    category_id = params[:category_id]
    post = Post.by_category(category_id)
    render json: post
  end 

  def by_author
    user_id = params[:user_id]
    post = Post.by_author(user_id)
    render json: post.order(created_at: :desc)
  end

  def post_analytics
    post = Post.find(params[:id])
    analytics = {
      post_id: post.id,
      title: post.title,
      total_views: post.views.count,
      total_likes: post.likes.count,
      total_comments: post.comments.count,
      total_reports: post.reports.count,
      category_names: post.categories.pluck(:category_name)
    }
    render json: analytics
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :status, :user_id, category_ids: [])
  end
  
end
