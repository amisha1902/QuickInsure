class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_category, only: %i[ show update destroy ]

  def index
    @categories = Category.all
    render json: @categories
  end

  def show
     render json: @category
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    render json: {message: "Category deleted successfully"}
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end
  def category_params
    params.require(:category).permit(:category_name, :description)
  end
end
