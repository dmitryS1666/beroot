class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_category, only: :show

  def index
    @categories = Category.where.not(parent_id: '', status: true)
  end

  def show
    @products = @category.products

    child_categories = Category.where(parent_id: @category.category_id, status: true)
    if child_categories.count > 0
      child_categories.each do |cat|
        @products = @products.merge(cat.products)
      end
    end

    @products = @products.paginate(page: params[:page])
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :photo)
  end

  def set_category
    @category = Category.find_by(id: params[:id], status: true)
  end
end
