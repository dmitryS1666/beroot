Trestle.resource(:products) do
  menu do
    item 'Продукты', '/admin/products', icon: "fa fa-shopping-bag", group: :configuration, priority: :first
  end

  search do |query|
    if query
      Product.where("name ILIKE ?", "%#{query}%")
    else
      Product.all
    end
  end

  # scopes do
  #   scope :all, -> { Product.all.order(created_at: :desc) }, default: true
  #   # Category.all.each do |category|
  #   #   next if Product.where(category_id: category).count == 0
  #   #   scope category.name, -> { Product.where(category_id: category).order(created_at: :desc) }, default: true
  #   # end
  # end

  table do
    column :name
    column :article, header: "Артикул", align: :right
    column :provider, header: "Поставщик", align: :center
    column :price, header: "Цена, &#8381;".html_safe, align: :center
    column :sale, header: "Скидка", align: :center
    column :qty_type, header: "Кол-во текст", align: :center
    column :quantity, header: "Кол-во", align: :center
    column :category_id, header: "Категория", align: :center do |product|
      Category.find(product.category_id)
    end
    column :created_at, header: "Дата создания", align: :center do |product|
      product.created_at.strftime("%Y-%m-%d %H:%M")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |product|
      product.updated_at.strftime("%Y-%m-%d %H:%M")
    end
    actions
  end

  form do |product|
    row do
      col(sm: 3) { text_field :name }
      col(sm: 3) { select :category_id, Category.all.map { |cat| [cat.name, cat.id] } }
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
