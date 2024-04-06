class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    mail_to = Config.find_by(name: 'mail_to').value
    mail(to: mail_to, subject: 'Новый заказ')
  end
end
