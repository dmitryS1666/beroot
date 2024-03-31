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
end
