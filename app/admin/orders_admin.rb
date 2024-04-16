Trestle.resource(:orders) do
  menu do
    item 'Заказы', '/admin/orders', icon: "fa fa-first-order", group: :clients
  end

  scopes do
    scope :all, -> { Order.all.order(created_at: :desc) }, default: true
  end

  table do
    column :name, header: "Имя", align: :center
    column :phone_number, header: "Номер телефона", align: :center
    column :items, header: "Позиций", align: :center do |order|
      Orderable.where(cart_id: order.cart_id).count
    end
    column :status, header: "Статус", align: :center do |item|
      case Cart.find(item.cart_id).status
      when 'active'
        "<span style='color: green;'>активный<span>".html_safe
      when 'pending'
        "<span style='color: orange;'>в обработке<span>".html_safe
      else
        "<span style='color: red;'>обработан<span>".html_safe
      end
    end
    column :created_at, header: "Дата создания", align: :center do |order|
      order.created_at.strftime("%Y-%m-%d %H:%M")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |order|
      order.updated_at.strftime("%Y-%m-%d %H:%M")
    end
  end

  form do |order|
    row do
      case Cart.find(order.cart_id).status
      when 'active'
        "<span style='color: green; padding-left: 10px; font-size: 18px;'>активный<span>".html_safe
      when 'pending'
        "<span style='color: orange; padding-left: 10px; font-size: 18px;'>в обработке<span>".html_safe
      else
        "<span style='color: red; padding-left: 10px; font-size: 18px;'>обработан<span>".html_safe
      end
    end

    row do
      col(sm: 3) { text_field :name, disabled: true }
      col(sm: 3) { text_field :phone_number, disabled: true }
    end

    row do
      "<h2>Позици:</h2>".html_safe
    end
    Orderable.where(cart_id: order.cart_id).each do |item|
      row do
        col(sm: 1) { 'Кол-во: ' + item.quantity.to_s }
        col(sm: 5) { Product.find(item.product_id).name }
      end
    end

    row do
      "<h2 style='margin-top: 20px;'>Изменить Статус заказа:</h2>".html_safe
    end
    row do
      col(sm: 3) { "<a href='/admin/carts/#{order.cart_id}'>Статус заказа можно изменить в корзине покупателя</a>".html_safe }
    end
  end
end
