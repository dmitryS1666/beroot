class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :products
  before_save :remove_attach_img_by_flag

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates_associated :products
  has_one_attached :photo

  def normalize_friendly_id(input)
    input.to_slug.transliterate(:russian).normalize.to_s
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

  def remove_attach_img_by_flag
    photo.purge if delete_file? && photo.attached?
    self.delete_file = false
  end
end
