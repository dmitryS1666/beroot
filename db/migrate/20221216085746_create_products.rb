class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :name
      t.string :article
      t.string :provider
      t.string :description
      t.integer :price
      t.integer :sale, default: 0, null: false
      t.string :qty_type
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
