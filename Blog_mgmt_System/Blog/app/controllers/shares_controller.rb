class SharesController < ApplicationController
  skip_before_action :verify_authenticity_token
 
 def create
    @share = Share.new(share_params)
    if @share.save
      render json: @share, status: :created
    else
      render json: @share.errors, status: :unprocessable_entity
    end
 end
 def index
    if params[:post_id]
      @shares = Share.where(post_id: params[:post_id])
    else 
      render json: { error: "postid is required"}, status: :bad_request and return
    end
    render json: @shares
  end 

  def share_params
    params.require(:share).permit(:user_id, :post_id) 
  end
end