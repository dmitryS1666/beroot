Trestle.resource(:about_sliders) do
  menu do
    item 'Слайдер О Компании', '/admin/about_sliders', icon: "fa fa-sliders", group: :configuration, priority: :first
  end

  table do
    column :video_link, header: "Видео", align: :center do |about|
      if about.video_link
        about.video_link
      else
        '-'
      end
    end
    column :photo, header: "Слайд", align: :center do |about|
      if about.photo.attached?
        image_tag main_app.rails_blob_path(about.photo),
                  style: 'max-width: 250px; height: auto;'
      else
        '-'
      end
    end

    column :created_at, header: "Дата создания", align: :center do |about|
      about.created_at.strftime("%Y-%m-%d")
    end
    column :updated_at, header: "Дата редактирования", align: :center do |about|
      about.updated_at.strftime("%Y-%m-%d")
    end
    actions
  end

  form do |promo|

    row do
      col(sm: 6) { '<span><i>Пример ссылки YouTube <b>https://www.youtube.com/embed/tgbNymZ7vqY</b></i></span>'.html_safe }
    end
    row do
      col(sm: 6) { text_field :video_link }
    end

    row do
      col(sm: 6) { '<span><i>Необходимый размер слайда 590 * 550px</i></span>'.html_safe }
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
