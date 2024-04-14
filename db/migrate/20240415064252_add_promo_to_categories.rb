class AddPromoToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :promo, :boolean, default: false
  end
end
