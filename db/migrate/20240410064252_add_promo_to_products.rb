class AddPromoToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :promo, :boolean, default: false
  end
end
