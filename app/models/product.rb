class Product < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model
  pg_search_scope :search_everywhere, against: [
    :name,
    :article,
    :provider,
    :description
  ], using: { tsearch: { prefix: true } }

  friendly_id :name, use: :slugged

  validates :category_id, presence: true
  validates :name, presence: true

  belongs_to :user
  belongs_to :category
  has_many_attached :photos
  has_many :orderables
  has_many :carts, through: :orderables

  self.per_page = 12

  def to_param
    slug
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
