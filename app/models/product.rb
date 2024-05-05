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
    # Путь к водяному знаку
    watermark_path = Rails.root.join('public', 'watermark.png').to_s

    # Открываем входное изображение
    image = MiniMagick::Image.read(image_blob.download)

    # Открываем водяной знак
    watermark = MiniMagick::Image.open(watermark_path)

    # Налагаем водяной знак на изображение
    image = image.composite(watermark) do |c|
      c.gravity "center"
    end

    # Создаем новый объект ActiveStorage::Blob с измененным изображением
    new_image_blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(image.to_blob),
      filename: "#{image_blob.filename}",
      content_type: image_blob.content_type
    )

    image_blob.purge if image_blob.present?

    # Заменяем прикрепленное изображение новым
    self.photos.attach(new_image_blob)
  end
end
