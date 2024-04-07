Trestle.resource(:feedbacks) do
  menu do
    item 'Обратная связь', '/admin/feedbacks', icon: "fa fa-comments", group: :clients
  end

  scopes do
    scope :all, -> { Feedback.all.order(created_at: :desc) }, default: true
  end

  table do
    column :name, header: "Имя".html_safe, align: :center
    column :last_name, header: "Фамилия".html_safe, align: :center
    column :email, header: "Email".html_safe, align: :center
    column :phone, header: "Номер телефона".html_safe, align: :center
    column :message, header: "Сообщение".html_safe, align: :center
    column :created_at, header: "Дата создания", align: :center do |cart|
      cart.created_at.strftime("%Y-%m-%d %H:%M")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |cart|
      cart.updated_at.strftime("%Y-%m-%d %H:%M")
    end
    actions
  end

  form do |feedback|
    row do
      col(sm: 3) { text_field :name, disabled: true }
      col(sm: 3) { text_field :last_name, disabled: true }
    end
    row do
      col(sm: 3) { text_field :email, disabled: true }
      col(sm: 3) { text_field :phone, disabled: true }
    end
    row do
      col(sm: 3) { text_area :message, disabled: true }
    end
    row do
      col(sm: 3) { date_field :created_at, disabled: true }
      col(sm: 3) { date_field :updated_at, disabled: true }
    end
  end
end
