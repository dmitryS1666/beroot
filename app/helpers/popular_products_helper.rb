module PopularProductsHelper
  def set_popular_product
    @popular_products = Product.order("RANDOM()").limit(10)
  end

  def set_top_rated_product
    @top_rated_products = Product.order("RANDOM()").limit(3)
  end
end