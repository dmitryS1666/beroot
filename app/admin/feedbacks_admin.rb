Trestle.resource(:feedbacks) do
  menu do
    item :feedbacks, icon: "fa fa-star"
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
      cart.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |cart|
      cart.updated_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do |feedback|
    row do
      col(sm: 3) { text_field :name }
      col(sm: 3) { select :category_id, Category.all.map { |cat| [cat.name, cat.id] } }
      # col(sm: 3) { select [Category.all.category_id] }
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
