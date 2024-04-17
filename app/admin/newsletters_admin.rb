Trestle.resource(:newsletters) do
  menu do
    item 'Подписки', '/admin/newsletters', icon: "fa fa-rss", group: :clients
  end

  scopes do
    scope :all, -> { Newsletter.all.order(created_at: :desc) }, default: true
  end

  table do
    column :email, header: "Email".html_safe, align: :center
    column :created_at, header: "Дата создания", align: :center do |cart|
      cart.created_at.strftime("%Y-%m-%d %H:%M")
    end
    # actions
  end

  form do
    row do
      col(sm: 3) { text_field :email, disabled: true }
    end
    row do
      col(sm: 3) { text_field :created_at, disabled: true }
      col(sm: 3) { text_field :updated_at, disabled: true }
    end
  end
end
