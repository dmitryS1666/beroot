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
    @category = Category.find(params[:category])
    @results = Product.where(category_id: params[:category], provider: params[:provider])
  end
end