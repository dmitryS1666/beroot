class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:search] && params[:search][:category].blank?
      @search_results = Product.search_everywhere(params[:search][:query])

    elsif params[:search] && !params[:search][:category].blank?
      @category = Category.find(params[:search][:category])
      scope = Product.where(category_id: params[:search][:category])
      @search_results = scope.search_everywhere(params[:search][:query])
    else
      @search_results = Product.all
    end

    save_search_query if params[:search]

    @search_results = @search_results.order('price::integer DESC').paginate(page: params[:page])
  end

  private

  def save_search_query
    SearchQuery.create!(query: params[:search][:query], desc: "результат поиска: #{@search_results.count}")
  end
end