class Product < ApplicationRecord
  include PgSearch
  pg_search_scope :search_everywhere, against: [
    :name,
    :product_id,
    :article,
    :provider,
    :description,
    :category_id
  ]

  validates :category_id, presence: true
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :category
  has_many_attached :photos
  has_many :orderables
  has_many :carts, through: :orderables

  self.per_page = 12
end
