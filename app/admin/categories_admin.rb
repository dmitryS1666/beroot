Trestle.resource(:categories) do
  menu do
    item 'Категории', '/admin/categories', icon: "fa fa-object-group", group: :configuration, priority: :first
  end

  search do |query|
    if query
      Category.where("name ILIKE ?", "%#{query}%")
    else
      Category.all
    end
  end

  table do
    column :name, header: "Имя", sort: :name
    column :category_id, header: "Артикул", align: :center
    column :photo, header: "Иконка" do |img|
      if img.photo.attached?
        image_tag main_app.rails_blob_path(img.photo),
                  style: 'max-width: 250px; height: auto;'
      else
        'пусто'
      end
    end
    column :description, header: "Описание"
    column :parent_id, header: "Родительский артикул", align: :center
    column :created_at, header: "Дата создания", align: :center do |category|
      category.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |category|
      category.updated_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do |category|
    row do
      col(sm: 3) { text_field :name }
      col(sm: 3) { select :parent_id, Category.all.map { |cat| [cat.name, cat.id] } }
    end
    row do
      col(sm: 3) { text_field :slug }
      col(sm: 3) { datetime_field :created_at }
    end
    row do
      col(sm: 3) { file_field :photo, as: :file, input_html: { direct_upload: true } }

      if category.photo.attached?
        col(sm: 3) { image_tag main_app.rails_blob_path(category.photo),
                               style: 'max-width: 100%; height: auto;'
        }
      end
    end
    row do
      col(sm: 3) {}
      if category.photo.attached?
        col(sm: 3) { check_box :delete_file, class: 'dangerous-area' }
      end
    end
  end
end
