class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders, :babosa]

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
end
