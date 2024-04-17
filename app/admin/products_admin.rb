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
      col(sm: 3) { select :promo, [true, false] }
    end
    row do
      col(sm: 3) { text_field :article }
      col(sm: 3) { text_field :provider }
    end
    row do
      col(sm: 3) { text_field :qty_type }
      col(sm: 3) { text_field :quantity }
    end

    row do
      col(sm: 3) { file_field :photos, multiple: true, input_html: { direct_upload: true } }
    end

    if product.photos.attached?
      product.photos.each do |photo|
        row do
          col(sm: 3) { link_to "Удалить", products_admin_path(action: :update_photo, id: product.id, delete_photo_id: photo.id), method: :put, data: { confirm: "Вы уверены?" } }
          col(sm: 3) { image_tag main_app.rails_blob_path(photo),
                                 style: 'max-width: 100%; height: auto;'
          }
        end
      end
    end
  end

  controller do
    def update
      @product = Product.find(params[:id])
      if params[:delete_photo_id]
        photo = @product.photos.find_by_id(params[:delete_photo_id])
        photo.purge if photo.present?
      elsif params[:photos]
        params[:photos].each do |image|
          @product.photos.attach(image)
        end
        @product.save!
      else
        @product.update(product_params)
      end
      redirect_to products_admin_path(@product), notice: "Изображение успешно удалено."
    end

    def product_params
      params.require(:product).permit(:name, :category_id, :price, :sale, :article, :provider, :qty_type, :quantity, :promo, photos: [])
    end
  end
end
