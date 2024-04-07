Trestle.resource(:carts) do
  menu do
    item 'Корзина', '/admin/carts', icon: "fa fa-shopping-cart", group: :clients
  end

  scopes do
    scope :all, -> { Cart.all.order(created_at: :desc) }, default: true
  end

  table do
    column :id, header: "ID", align: :center
    column :status, header: "Статус", align: :center do |item|
      case item.status
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

  form do |cart|
    row do
      col(sm: 4) { select :status, [['в обработке', 'pending'], %w[обработан done]] }
    end

    Orderable.where(cart_id: cart.id).each do |item|
      row do
        col(sm: 1) { 'Кол-во: ' + item.quantity.to_s }
        col(sm: 5) { Product.find(item.product_id).name }
      end
    end
  end
end
