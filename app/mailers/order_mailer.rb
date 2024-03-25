class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    mail(to: 'agromaster.info@yandex.ru', subject: 'Новый заказ')
  end
end
