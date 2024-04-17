Trestle.resource(:search_queries) do
  menu do
    item 'История поисковых запросов', '/admin/search_queries', icon: "fa fa-search", group: :configuration, priority: :first
  end

  table do
    column :query, header: "Запрос", align: :center
    column :desc, header: "Результат", align: :center

    column :created_at, header: "Дата создания", align: :center do |category|
      category.created_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do
    row do
      col(sm: 9) { text_field :query, disabled: true }
    end
    row do
      col(sm: 6) { text_field :desc, disabled: true }
    end
    row do
      col(sm: 3) { text_field :created_at, disabled: true }
      col(sm: 3) { text_field :updated_at, disabled: true }
    end
  end
end
