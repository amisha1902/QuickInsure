class ViewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:post_id]
      @views = View.where(post_id: params[:post_id])
    else 
      render json: { error: "postid is required"}, status: :bad_request and return
    end
    render json: @views
  end 

  def create
    @view = View.new(view_params)

    if @view.save
      render json: @view, status: :created
    else
      render json: @view.errors, status: :unprocessable_entity
    end
  end

  private

  def set_view
    @view = View.find(params[:id]) 
  end

  def view_params
    params.require(:view).permit(:user_id, :post_id) 
  end
end