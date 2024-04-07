Trestle.resource(:orderables) do
  menu do
    item 'Позиции', '/admin/orderables', icon: "fa fa-first-order", group: :clients
  end

  scopes do
    scope :all, -> { Orderable.all.order(created_at: :desc) }, default: true
  end

  table do
    column :cart_id, header: "Корзина", sort: :cart_id, align: :center do |item|
      Cart.find(item.cart_id)
    end
    column :quantity, header: "Кол-во", align: :center
    column :product_id, header: "Продукт", align: :left do |item|
      Product.find(item.product_id)
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
    column :order_id, header: "Заказ", align: :left do |item|
      Order.find_by(cart_id: item.cart_id)
    end
    column :created_at, header: "Дата создания", align: :center do |item|
      item.created_at.strftime("%Y-%m-%d %H:%M")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |item|
      item.updated_at.strftime("%Y-%m-%d %H:%M")
    end
  end

  form do |order|
    row do
      col(sm: 3) { text_field :product_id, disabled: true }
      col(sm: 3) { text_field :cart_id, disabled: true }
    end
    row do
      col(sm: 3) { date_field :created_at, disabled: true }
      col(sm: 3) { date_field :updated_at, disabled: true }
    end
    row do
      col(sm: 3) { date_field :created_at, disabled: true }
      col(sm: 3) { date_field :updated_at, disabled: true }
    end
  end
end
