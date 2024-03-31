Trestle.resource(:newsletters) do
  menu do
    item :newsletters, icon: "fa fa-star"
  end

  scopes do
    scope :all, -> { Newsletter.all.order(created_at: :desc) }, default: true
  end

  table do
    column :email, header: "Email".html_safe, align: :center
    column :created_at, header: "Дата создания", align: :center do |cart|
      cart.created_at.strftime("%Y-%m-%d")
    end
    # actions
  end

  # form do |newsletter|
  #   row do
  #     col(sm: 3) { text_field :email }
  #   end
  #   row do
  #     col(sm: 3) { text_field :qty_type }
  #     col(sm: 3) { text_field :quantity }
  #   end
  # end
end
