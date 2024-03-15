class ResultsController < ApplicationController
  include MainCategoryHelper
  skip_before_action :authenticate_user!

  def index
    set_main_category

    if params[:search][:category].blank?
      @search_results = Product.search_everywhere(params[:search][:query])
    else
      scope = Product.where(category_id: params[:search][:category])
      @search_results = scope.search_everywhere(params[:search][:query])
    end

    @search_results
  end
end