class ProductsController < ApplicationController
  before_action :authenticate_user!, :only => [:new]
  before_action :set_product, only: [ :edit, :show, :update, :destroy ]
  before_action :set_categories, only: [:new, :create, :edit]

  def index
    @products = Product.all
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def show
    @products = Product.all
    @category = Category.new
    @product = Product.friendly.find(params[:id])
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_categories
    @categories = Category.all.order(:name)
  end

  def set_product
    @product = Product.friendly.find_by(slug: params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity,:category_id, :photos, photos: [])
  end
end
