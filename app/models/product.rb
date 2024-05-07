require 'mini_magick'

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders, :babosa]

  WATERMARK_PATH = Rails.root.join('lib', 'assets', 'images', 'watermark.png')

  include PgSearch::Model
  pg_search_scope :search_everywhere, against: [
    :name,
    :article,
    :provider,
    :description
  ], using: { tsearch: { prefix: true } }

  validates :category_id, presence: true
  validates :name, presence: true

  belongs_to :user
  belongs_to :category
  has_many_attached :photos
  has_many :orderables
  has_many :carts, through: :orderables

  self.per_page = 12

  def normalize_friendly_id(input)
    input.to_slug.transliterate(:russian).normalize.to_s
  end

  def apply_watermark(image_blob)
    image = MiniMagick::Image.read(image_blob.download)

    # Находим ширину и высоту изображения
    width = image.width
    height = image.height

    # Создаем временное изображение с повторяющимся текстом и поворотом
    watermark_text_image = image.combine_options do |b|
      %w[south north center].each do |position|
        b.size "#{width}x#{height}"
        b.gravity position
        b.fill "rgba(128, 128, 128, 0.3)"
        b.pointsize 50
        b.draw "rotate -45 text 0,0 'АгроМастер Тверь АгроМастер Тверь АгроМастер Тверь'"
      end
    end

    # Налагаем текст водяного знака на изображение
    image = image.composite(watermark_text_image) do |c|
      c.compose "Over"
      c.geometry "+0+0"
    end

    # Создаем новый объект ActiveStorage::Blob с измененным изображением
    new_image_blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(image.to_blob),
      filename: "#{image_blob.filename}",
      content_type: image_blob.content_type
    )

    # Заменяем прикрепленное изображение новым
    self.photos.attach(new_image_blob)

    # Удаляем временное изображение
    watermark_text_image.destroy!

    # Удаляем старое изображение, если оно было
    image_blob.purge if image_blob.present?
  end
end
