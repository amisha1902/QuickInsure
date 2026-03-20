class ReportsController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :set_post, only: [:index, :create] 

 def index
    @reports = @post.reports
    render json: @reports.order(created_at: :desc)
  end

  def create
    user_id = params[:user_id]
    if user_id.blank?
      render json: { message: "user not found" }, status: :bad_request and return
    end
    @report = @post.reports.find_by(user_id: user_id)
    if @report
      render json: { message: "you have already reported this post" } and return
    else
      @report = @post.reports.new(user_id: user_id, reason: params[:reason], description: params[:description])
      if @report.save
        render json: { message: "post reported by you"}
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    @report = Report.find(params[:id])
    puts @report.inspect
    render json: @report
  end
  

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
    unless @post
      render json: { error: "Post not found" }, status: :not_found and return
    end
  end

end
