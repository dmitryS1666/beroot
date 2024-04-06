class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates_associated :products
  has_one_attached :photo

  def to_param
    slug
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def count_products
    products = self.products
    child_categories = Category.where(parent_id: category_id, status: true)
    if child_categories.count > 0
      category_ids = child_categories.map(&:id) << self.id
      products = Product.where('category_id IN (?)', category_ids)
    end
    products.count
  end
end
