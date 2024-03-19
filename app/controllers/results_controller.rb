class ResultsController < ApplicationController
  include MainCategoryHelper
  skip_before_action :authenticate_user!

  def index
    set_main_category

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
end