class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :phone_number
      t.string :name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :message
      t.integer :cart_id

      t.timestamps
    end
  end
end
