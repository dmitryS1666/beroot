class Promo < ApplicationRecord
  has_many :products
  has_one_attached :photo

end
