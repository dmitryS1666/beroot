Trestle.resource(:orders) do
  menu do
    item :orders, icon: "fa fa-star"
  end

  scopes do
    scope :all, -> { Order.all.order(created_at: :desc) }, default: true
    # Category.all.each do |category|
    #   next if Product.where(category_id: category).count == 0
    #   scope category.name, -> { Product.where(category_id: category).order(created_at: :desc) }, default: true
    # end
  end

  table do
    column :name
    column :last_name
    column :phone_number, header: "Номер телефона", align: :right
    column :address, header: "Поставщик", align: :center
    column :city, header: "Цена, &#8381;".html_safe, align: :center
    column :message, header: "Цена, &#8381;".html_safe, align: :center
    column :cart_id, header: "Скидка", align: :center do |order|
      Cart.find(order.cart_id)
    end
    column :created_at, header: "Дата создания", align: :center do |order|
      order.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |order|
      order.updated_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do |order|
    row do
      col(sm: 3) { text_field :name }
      col(sm: 3) { select :category_id, Category.all.map { |cat| [cat.name, cat.id] } }
      # col(sm: 3) { select [Category.all.category_id] }
    end
    row do
      col(sm: 3) { text_field :price }
      col(sm: 3) { text_field :sale }
    end
    row do
      col(sm: 3) { text_field :article }
      col(sm: 3) { text_field :provider }
    end
    row do
      col(sm: 3) { text_field :qty_type }
      col(sm: 3) { text_field :quantity }
    end
  end
end
