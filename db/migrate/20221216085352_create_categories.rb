class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :category_id
      t.string :name
      t.string :description
      t.string :parent_id
      t.boolean :status
      t.boolean :main_page, default: false
      t.timestamps
    end
  end
end
