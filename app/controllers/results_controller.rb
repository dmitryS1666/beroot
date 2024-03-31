class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # simple search
    if params[:search] && params[:search][:category].blank?
      @search_results = Product.search_everywhere(params[:search][:query])

      # simple search + category
    elsif params[:search] && !params[:search][:category].blank?
      @category = Category.find(params[:search][:category])
      scope = Product.where(category_id: params[:search][:category])
      @search_results = scope.search_everywhere(params[:search][:query])
    else
      @search_results = Product.all
    end

    @search_results
  end

  def filter
    @provider = params[:provider]
    if params.has_key?(:category)
      if params.has_key?(:price_from) || params.has_key?(:price_to)
        @category = Category.find(params[:category])
        scope = Product.where(category_id: params[:category])
        @results = scope.where("price >= #{params[:price_from]} AND price <= #{params[:price_to]}")
      else
        @category = Category.find(params[:category])
        @results = Product.where(category_id: params[:category], provider: params[:provider])
      end
    elsif params.has_key?(:price_from) || params.has_key?(:price_to)
      @results = Product.where("price >= #{params[:price_from]} AND price <= #{params[:price_to]}").order('price DESC')
    end
  end
end