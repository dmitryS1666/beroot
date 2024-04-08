class AddDeleteFileCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :delete_file, :boolean
  end
end
