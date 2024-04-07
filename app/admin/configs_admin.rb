Trestle.resource(:configs) do
  menu do
    item "Конфиги", "/admin/configs", icon: "fa fa-wrench", group: :configuration, priority: :last
  end

  table do
    column :name
    column :value
    column :created_at, header: "Дата создания", align: :center do |cart|
      cart.created_at.strftime("%Y-%m-%d %H:%M")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |cart|
      cart.updated_at.strftime("%Y-%m-%d %H:%M")
    end
    actions
  end

  form do
    row do
      col(sm: 3) { text_field :name }
      col(sm: 3) { text_field :value }
    end
  end
end
