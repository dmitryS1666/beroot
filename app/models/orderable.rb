class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total
    product.price * quantity
  end

  def self.group_by_cart
    cart_ids = Orderable.distinct.pluck(:cart_id)

    # Группируем заказы по cart_id
    grouped_orders = {}
    cart_ids.each do |cart_id|
      grouped_orders[cart_id] = Orderable.where(cart_id: cart_id)
    end

    grouped_orders
  end
end
