Trestle.resource(:configs) do
  menu do
    item :configs, icon: "fa fa-star", header: 'Корзина
'
  end

  table do
    column :name
    column :value
    column :created_at, header: "Дата создания", align: :center do |cart|
      cart.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |cart|
      cart.updated_at.strftime("%Y-%m-%d")
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
