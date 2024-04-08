class AddDeleteFileProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :delete_file, :boolean
  end
end
