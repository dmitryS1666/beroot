Trestle.resource(:promos) do
  menu do
    item 'Промо', '/admin/promos', icon: "fa fa-object-group", group: :configuration, priority: :first
  end

  table do
    column :product_id, header: "Имя", align: :center do |promo|
      Product.find(promo.product_id).name
    end
    column :photo, header: "Слайд", align: :center do |promo|
      if promo.photo.attached?
        image_tag main_app.rails_blob_path(promo.photo),
                  style: 'max-width: 250px; height: auto;'
      else
        'пусто'
      end
    end

    column :created_at, header: "Дата создания", align: :center do |category|
      category.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |category|
      category.updated_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do |promo|
    row do
      col(sm: 3) { select :product_id, Product.all.map { |pr| [pr.name, pr.id] } }
    end
    row do
      col(sm: 3) { file_field :photo, as: :file, input_html: { direct_upload: true } }

      if promo.photo.attached?
        col(sm: 3) { image_tag main_app.rails_blob_path(promo.photo),
                               style: 'max-width: 100%; height: auto;'
        }
      end
    end
  end
end
