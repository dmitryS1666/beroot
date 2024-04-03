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

    @all_category_products = @products.order('price::integer DESC')

    if params.has_key?(:price_from) || params.has_key?(:price_to)
      price_from = params[:price_from].blank? ? params[:price_min] : params[:price_from]
      price_to = params[:price_to].blank? ? params[:price_max] : params[:price_to]
      @products = @products.where("price >= #{price_from} AND price <= #{price_to}")
    end

    @products = @products.order('price::integer DESC').paginate(page: params[:page])
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :photo)
  end

  def set_category
    @category = Category.friendly.find_by(slug: params[:id], status: true)
  end
end
