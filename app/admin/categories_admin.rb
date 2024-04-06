Trestle.resource(:categories) do
  menu do
    item :categories, icon: "fa fa-star"
  end

  #  scopes do
  #     scope :all, -> { Category.all.order(created_at: :desc) }, default: true
  #     scope :ru, -> { Category.where(language: "ru") }
  #   end

  table do
    column :name, header: "Имя"
    column :category_id, header: "Артикул", align: :center
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
      # col(sm: 3) { select :parent_id, Category.all.map { |cat| [cat.name, cat.id, { selected: (cat.id == item.cat_grade_id) }] } }
      col(sm: 3) { select :parent_id, Category.all.map { |cat| [cat.name, cat.id] } }
      # col(sm: 3) { select [Category.all.category_id] }
    end
    row do
      col(sm: 3) { text_field :slug }
      col(sm: 3) { datetime_field :created_at }
    end
    # row do
    #   col(sm: 3) { file_field :image, as: :file, input_html: { direct_upload: true } }
    #
    #   if category.image.attached?
    #     col(sm: 3) { image_tag main_app.rails_blob_path(category.image),
    #                            style: 'max-width: 100%; height: auto;'
    #     }
    #   end
    # end
    # row do
    #   col(sm: 3) {}
    #   if category.image.attached?
    #     col(sm: 3) { check_box :delete_file, class: 'dangerous-area' }
    #   end
    # end

    # row do
    #   col(sm: 9) { text_area :content }
    # end
  end
end
