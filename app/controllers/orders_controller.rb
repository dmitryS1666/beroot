class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sent]

  def sent
    @order = Order.new(order_params)
    @order[:created_at] = Time.zone.now
    @order[:cart_id] = params[:order][:cart_id]

    cart = Cart.find(@order[:cart_id])
    cart.status = 'pending'
    cart.save

    if @order.save
      OrderMailer.order_email(@order).deliver_now
      redirect_to root_path, notice: 'Спасибо! Ваше заказ принят! Ожидайте, наш менеджер свяжется с Вами.'
    else
      redirect_to cart_path, notice: 'Что-то пошло не так...'
    end
  end

  private

  def order_params
    params.permit(:phone_number, :name, :last_name, :address, :city, :message, :orderables)
  end
end
