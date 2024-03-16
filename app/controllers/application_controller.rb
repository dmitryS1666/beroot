class ApplicationController < ActionController::Base
  include MainCategoryHelper
  include PopularProductsHelper

  before_action :authenticate_user!
  before_action :set_render_cart
  before_action :initialize_cart
  before_action :set_main_category
  before_action :set_popular_product
  before_action :set_top_rated_product

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
